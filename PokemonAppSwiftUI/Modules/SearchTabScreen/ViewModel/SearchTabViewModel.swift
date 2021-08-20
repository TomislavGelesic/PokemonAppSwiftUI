

import SwiftUI
import Combine
import Alamofire

class SearchTabViewModel: ObservableObject {
    
    @Published var pokemons: [RowItem<SearchTabRowItemType, Pokemon>] = [RowItem<SearchTabRowItemType, Pokemon>(type: .noData, value: Pokemon())]
    @Published var allPokemons: [RowItem<SearchTabRowItemType, Pokemon>] = [RowItem<SearchTabRowItemType, Pokemon>(type: .noData, value: Pokemon())]
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeToPublishedData(_allPokemons) { self.isLoading = false }
        subscribeToPublishedData(_pokemons) { self.isLoading = false }
    }
    
    private func subscribeToPublishedData<T>(_ data: Published<T>, completion: @escaping (()->())) {
        _allPokemons.projectedValue
            .receive(on: DispatchQueue.global(qos: .background))
            .subscribe(on: RunLoop.main)
            .sink { _ in
                DispatchQueue.main.async {
                    completion()
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchPokemonList() {
        isLoading = true
        RestManager.requestObservable(url: RestEndpoints.pokemonList.endpoint(), dataType: [PokemonItemResponse].self)
            .map { [unowned self] result -> [RowItem<SearchTabRowItemType, Pokemon>] in
                switch result {
                case .success(let response):
                    return self.createPokemons(from: response)
                case .failure(_):
                    return self.createPokemonsWithNoData()
                }
            }
            .assign(to: &$allPokemons)
    }
    
    func searchPokemonList(_ inputSearch: String) {
        var filteredList = allPokemons.filter { $0.value.name.localizedCaseInsensitiveContains(inputSearch) }
        if filteredList.isEmpty {
            filteredList.append(RowItem<SearchTabRowItemType, Pokemon>(type: .noSearchResult, value: Pokemon()))
        }
        pokemons = filteredList
    }
    
    private func createPokemons(from response: [PokemonItemResponse]) -> [RowItem<SearchTabRowItemType, Pokemon>] {
        return response
            .map {
                RowItem<SearchTabRowItemType, Pokemon>(type: .foundSearchResult,
                                                       value: Pokemon(id: $0.id,
                                                                      name: $0.name.english,
                                                                      hp: $0.base?.HP ?? 0,
                                                                      attack: $0.base?.Attack ?? 0,
                                                                      defense: $0.base?.Defense ?? 0,
                                                                      imageUrl: $0.imageURL ?? ""))
            }
    }
    
    private func createPokemonsWithNoData() -> [RowItem<SearchTabRowItemType, Pokemon>] {
        return [RowItem<SearchTabRowItemType, Pokemon>(type: .noData, value: Pokemon())]
    }
}
