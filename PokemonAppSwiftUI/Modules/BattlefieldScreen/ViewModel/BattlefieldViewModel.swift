
import SwiftUI
import CoreData
import Combine



class BattleFieldViewModel: ObservableObject {
    
    var databaseContext: NSManagedObjectContext
    
    @Published var state: BattlefieldState = .init()
    
    private let eventSubject = CurrentValueSubject<BattlefieldEvent, Never>(.onAppear)
    private let fetchScreenDataSubject = PassthroughSubject<Void, Never>()
    private var disposeBag = Set<AnyCancellable>()
    
    init(databaseContext: NSManagedObjectContext) {
        self.databaseContext = databaseContext
        initializeEventSubject(eventSubject)
        initializeFetchScreenDataSubject(fetchScreenDataSubject)
        fetchScreenDataSubject.send()
    }
    
}

extension BattleFieldViewModel {
    
    private func initializeEventSubject(_ subject: CurrentValueSubject<BattlefieldEvent, Never>) {
        return subject
            .map { event in self.reduce(&self.state, event) }
            .receive(on: RunLoop.main)
            .assign(to: &$state)
    }
    
    func sendEvent(_ event: BattlefieldEvent) {
        eventSubject.send(event)
    }
    
    private func reduce(_ state: inout BattlefieldState, _ event: BattlefieldEvent) -> BattlefieldState {
        switch state.status {
        case .idle:
            switch event {
            case .onAppear:
                state.status = .loading
            case .onOccuredError(let error):
                state.status = .error(error)
            case .onSelectPokemon(let selectedPokemonType, let pokemon):
                switch selectedPokemonType {
                case .availablePokemons: state.selectedPokemon = pokemon
                case .enemyPokemons: state.selectedEnemyPokemon = pokemon
                default: state.status = .error(.recoverable())
                }
                state.status = .idle
            case .onShowFightResults:
                state.battleResult = getBattleResultForSelectedPokemons()
            default: break
            }
        case .loading:
            switch event {
            case .onOccuredError(let error):
                state.status = .error(error)
            case .onFinishedLoading(let newScreenData):
                state.selectedPokemon = nil
                state.selectedEnemyPokemon = nil
                state.screenData = newScreenData
                state.status = .idle
            default: break
            }
        case .error(_):
            switch event {
            case .onDismissError:
                state.status = .loading
            default: break
            }
        }
        return state
    }
}


extension BattleFieldViewModel {
    
    private func initializeFetchScreenDataSubject(_ subject: PassthroughSubject<Void, Never>) {
        subject
            .flatMap { [unowned self] (_) -> AnyPublisher<RowItem<BattlefieldRowItemType, Any>?, Never> in
                self.fetchWildPokemons()
            }
            .map { [unowned self] wildPokemons -> [RowItem<BattlefieldRowItemType, Any>] in
                return self.createScreenData(wildPokemons: wildPokemons, availablePokemons: self.fetchSavedPokemons())
            }
            .sink { [unowned self] newScreenData in
                self.sendEvent(.onFinishedLoading(newScreenData))
            }
            .store(in: &disposeBag)
    }
    
    private func fetchWildPokemons() -> AnyPublisher<RowItem<BattlefieldRowItemType, Any>?, Never> {
        return Publishers
            .Zip3(RestManager.requestObservable(url: RestEndpoints.randomPokemon.endpoint(), dataType: PokemonItemResponse.self),
                  RestManager.requestObservable(url: RestEndpoints.randomPokemon.endpoint(), dataType: PokemonItemResponse.self),
                  RestManager.requestObservable(url: RestEndpoints.randomPokemon.endpoint(), dataType: PokemonItemResponse.self))
            .flatMap { [unowned self] (result1, result2, result3) -> AnyPublisher<RowItem<BattlefieldRowItemType, Any>?, Never> in
                var enemyPokemons = [Pokemon]()
                switch result1 {
                case .success(let responseData1):
                    enemyPokemons.append(self.createPokemon(from: responseData1))
                case .failure(_):
                    return Just(nil).eraseToAnyPublisher()
                }
                switch result2 {
                case .success(let responseData2):
                    enemyPokemons.append(self.createPokemon(from: responseData2))
                case .failure(_):
                    return Just(nil).eraseToAnyPublisher()
                }
                switch result3 {
                case .success(let responseData3):
                    enemyPokemons.append(self.createPokemon(from: responseData3))
                case .failure(_):
                    return Just(nil).eraseToAnyPublisher()
                }
                let item: RowItem<BattlefieldRowItemType, Any>? = .init(type: .enemyPokemons, value: enemyPokemons)
                return Just(item).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func createScreenData(wildPokemons: RowItem<BattlefieldRowItemType, Any>?, availablePokemons: RowItem<BattlefieldRowItemType, Any>?) -> [RowItem<BattlefieldRowItemType, Any>] {
        var newScreenData = [RowItem<BattlefieldRowItemType, Any>]()
        if let wildPokemons = wildPokemons,
           let availablePokemons = availablePokemons {
            newScreenData.append(wildPokemons)
            newScreenData.append(availablePokemons)
        }
        else {
            newScreenData.append(RowItem<BattlefieldRowItemType, Any>(type: .empty, value: "No available Pokemons"))
        }
        return newScreenData
    }
    
    private func createPokemon(from response: PokemonItemResponse) -> Pokemon {
        return Pokemon(id: response.id,
                       name: response.name.english,
                       hp: response.base?.HP ?? 0,
                       attack: response.base?.Attack ?? 0,
                       defense: response.base?.Defense ?? 0,
                       imageUrl: response.imageURL ?? "")
        
    }
    
    private func fetchSavedPokemons() -> RowItem<BattlefieldRowItemType, Any>? {
        let request = NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
        do {
            let savedPokemons = try databaseContext
                .fetch(request)
                .map{ PokemonDatabaseManager.createPokemon(from: $0) }
            return RowItem<BattlefieldRowItemType, Any>(type: .availablePokemons, value: savedPokemons)
        } catch let error {
            print("Error occured: \(error)")
        }
        return nil
    }
    
    private func saveContext() {
        if databaseContext.hasChanges {
            do {
                try databaseContext.save()
            } catch let error {
                print("error occured: \(error)")
            }
        }
    }
    
    private func saveNewPokemon(pokemon: Pokemon) {
        _ = PokemonDatabaseManager.createPokemonEntity(from: pokemon, inContext: databaseContext)
        saveContext()
    }
}

extension BattleFieldViewModel {
    
    func getBattleResultForSelectedPokemons() -> BattleResult? {
        if let pokemon = state.selectedPokemon,
           let enemy = state.selectedEnemyPokemon {
            if didWin(pokemon: pokemon, enemy: enemy) {
                saveNewPokemon(pokemon: enemy)
                return BattleResult(pokemon: pokemon, enemyPokemon: enemy, didWin: true)
            }
            return BattleResult(pokemon: pokemon, enemyPokemon: enemy, didWin: false)
        }
        return nil
    }
    
    private func didWin(pokemon: Pokemon, enemy: Pokemon) -> Bool {
        
        if pokemon.id == 25 { return didPikachuWin(pokemon: pokemon, enemy: enemy) }
        
        var pokemonHP = pokemon.hp
        var enemyHP = enemy.hp
        var enemyDefense = enemy.defense
        var pokemonDefense = pokemon.defense
        
        while enemyDefense > 0 && pokemonDefense > 0 {
            enemyDefense -= pokemon.attack/10
            pokemonDefense -= enemy.attack/10
        }
        while enemyHP > 0 && pokemonHP > 0 {
            enemyHP -= pokemon.attack/10
            pokemonHP -= enemy.attack/10
        }
        
        let pokemonPoints = calculatePoints(remainingDefense: pokemonDefense, remainingHP: pokemonHP)
        let enemyPoints = calculatePoints(remainingDefense: enemyDefense, remainingHP: enemyHP)
        return pokemonPoints > enemyPoints ? true : false
    }
    
    private func didPikachuWin(pokemon: Pokemon, enemy: Pokemon) -> Bool {
        var pokemonHP = pokemon.hp
        var enemyHP = enemy.hp
        var enemyDefense = enemy.defense
        var pokemonDefense = pokemon.defense
        
        if Bool.random() {
            enemyDefense /= 2
        }
        while enemyDefense > 0 && pokemonDefense > 0 {
            enemyDefense -= pokemon.attack/10
            pokemonDefense -= enemy.attack/10
        }
        
        if Bool.random() {
            enemyHP /= 2
        }
        while enemyHP > 0 && pokemonHP > 0 {
            enemyHP -= pokemon.attack/10
            pokemonHP -= enemy.attack/10
            
        }
        
        let pokemonPoints = calculatePoints(remainingDefense: pokemonDefense, remainingHP: pokemonHP)
        let enemyPoints = calculatePoints(remainingDefense: enemyDefense, remainingHP: enemyHP)
        return pokemonPoints > enemyPoints ? true : false
    }
    
    private func getPositiveOrZero(_ number: Int) -> Int {
        if number < 0 { return 0 }
        return number
    }
    
    private func calculatePoints(remainingDefense defense: Int, remainingHP hp: Int) -> Int {
        return (getPositiveOrZero(defense) * 100) + (getPositiveOrZero(hp) * 10)
    }
}
