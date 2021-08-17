
import SwiftUI
import CoreData
import Combine

class BattleFieldViewModel: ObservableObject {
    
    let backgroundImageName: String = "battlefield_backgroundImage"
    var databaseContext: NSManagedObjectContext
    @Published var screenData: [RowItem<BattlefieldViewRowItemType, Any>] = .init()
    @Published var isLoading: Bool = false
    
    @State private var selectedPokemon: Pokemon? = nil
    @State private var selectedEnemyPokemon: Pokemon? = nil
    
    init(databaseContext: NSManagedObjectContext) {
        self.databaseContext = databaseContext
        self.createScreenData()
    }
    
}

extension BattleFieldViewModel {
    
    func createView(for type: BattlefieldViewRowItemType, contentWidth width: CGFloat) -> AnyView {
        let filteredData = screenData.filter { $0.type == type }
        for item in filteredData {
            switch item.type {
            case .availablePokemons:
                guard let availablePokemons = item.value as? [Pokemon] else { return AnyView(EmptyView()) }
                var view: some View {
                    PokemonPickerGalleryView(contentWidth: width,
                                             shouldShowStats: false,
                                             isSelectable: true,
                                             pokemons: availablePokemons,
                                             onSelection:
                                                { [unowned self] selectedIndex in
                                                    if selectedIndex < 0 { self.selectedPokemon = nil }
                                                    else { self.selectedPokemon = availablePokemons[selectedIndex] }
                                                })
                }
                return AnyView(view)
            case .enemyPokemons:
                guard let enemyPokemons = item.value as? [Pokemon] else { return AnyView(EmptyView()) }
                var view: some View {
                    PokemonPickerGalleryView(contentWidth: width,
                                             shouldShowStats: false,
                                             isSelectable: true,
                                             pokemons: enemyPokemons,
                                             onSelection:
                                                { [unowned self] selectedIndex in                                                    
                                                    if selectedIndex < 0 { self.selectedEnemyPokemon = nil }
                                                    else { self.selectedEnemyPokemon = enemyPokemons[selectedIndex] }
                                                })
                }
                return AnyView(view)
            }
        }
        return AnyView(EmptyView())
    }
}

extension BattleFieldViewModel {
    
    private func createScreenData() {
        isLoading = true
        enemyPokemonsPipeline()
            .map { [unowned self] enemyPokemons in
                var newScreenData = [RowItem<BattlefieldViewRowItemType, Any>]()
                if let enemyPokemons = enemyPokemons,
                   let savedPokemons = self.fetchSavedPokemons() {
                    newScreenData.append(enemyPokemons)
                    newScreenData.append(savedPokemons)
                }
                return newScreenData
            }
            .assign(to: &$screenData)
    }
    
    private func enemyPokemonsPipeline() -> AnyPublisher<RowItem<BattlefieldViewRowItemType, Any>?, Never> {
        return Publishers
            .Zip3(RestManager.requestObservable(url: RestEndpoints.randomPokemon.endpoint(), dataType: PokemonItemResponse.self),
                  RestManager.requestObservable(url: RestEndpoints.randomPokemon.endpoint(), dataType: PokemonItemResponse.self),
                  RestManager.requestObservable(url: RestEndpoints.randomPokemon.endpoint(), dataType: PokemonItemResponse.self))
            .flatMap { [unowned self] (result1, result2, result3) -> AnyPublisher<RowItem<BattlefieldViewRowItemType, Any>?, Never> in
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
                let item: RowItem<BattlefieldViewRowItemType, Any>? = .init(type: .enemyPokemons, value: enemyPokemons)
                return Just(item).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    private func createPokemon(from response: PokemonItemResponse) -> Pokemon {
        return Pokemon(id: response.id,
                       name: response.name.english,
                       hp: response.base?.HP ?? 0,
                       attack: response.base?.Attack ?? 0,
                       defense: response.base?.Defense ?? 0,
                       imageUrl: response.imageURL ?? "")
        
    }
    
    private func fetchSavedPokemons() -> RowItem<BattlefieldViewRowItemType, Any>? {
        let request = NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
        do {
            let savedPokemons = try databaseContext
                .fetch(request)
                .map{ PokemonDatabaseManager.createPokemon(from: $0) }
            return RowItem<BattlefieldViewRowItemType, Any>(type: .availablePokemons, value: savedPokemons)
        } catch let error {
            print("Error occured: \(error)")
        }
        return nil
    }
    
    private func saveContext() {
        if databaseContext.hasChanges {
            do {
                try databaseContext.save()
                createScreenData()
            } catch let error {
                print("error occured: \(error)")
            }
        }
    }
    
    private func didWin(pokemon: Pokemon, enemy: Pokemon) -> Bool {
        var pokemonHP = pokemon.hp
        var enemyHP = enemy.hp
        var enemyDefense = 0
        var pokemonDefense = 0
        
        while enemyDefense >= 0 && pokemonDefense >= 0 {
            enemyDefense -= pokemon.attack/10
            pokemonDefense = enemy.attack/10
        }
        while enemyHP >= 0 && pokemonHP >= 0 {
            enemyHP = pokemon.attack/10
            pokemonHP = enemy.attack/10
        }
        
        let pokemonPoints = (pokemonDefense * 100) + (pokemonHP * 10)
        let enemyPoints = (enemyDefense * 100) + (enemyHP * 10)
        return pokemonPoints > enemyPoints ? true : false
    }
    
    private func didPikachuWin(pokemon: Pokemon, enemy: Pokemon) -> Bool {
        var pokemonHP = pokemon.hp
        var enemyHP = enemy.hp
        var enemyDefense = 0
        var pokemonDefense = 0
        
        if Bool.random() {
            enemyDefense = 0
        }
        else {
            while enemyDefense >= 0 && pokemonDefense >= 0 {
                enemyDefense -= pokemon.attack/10
                pokemonDefense = enemy.attack/10
            }
        }
        if Bool.random() {
            enemyHP = 0
        }
        else {
            while enemyHP >= 0 && pokemonHP >= 0 {
                enemyHP = pokemon.attack/10
                pokemonHP = enemy.attack/10
            }
        }
        
        let pokemonPoints = (pokemonDefense * 100) + (pokemonHP * 10)
        let enemyPoints = (enemyDefense * 100) + (enemyHP * 10)
        return pokemonPoints > enemyPoints ? true : false
    }
    
    private func saveNewPokemon(pokemon: Pokemon) {
        _ = PokemonDatabaseManager.createPokemonEntity(from: pokemon, inContext: databaseContext)
        saveContext()
    }
}
