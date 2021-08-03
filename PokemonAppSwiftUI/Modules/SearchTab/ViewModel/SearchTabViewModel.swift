

import SwiftUI
import Combine
import Alamofire

class SearchTabViewModel: ObservableObject {
    @Published var pokemons: [RowItem<SearchTabRowItemType, Pokemon>] = [RowItem<SearchTabRowItemType, Pokemon>(type: .noData, value: Pokemon())]
    @Published var allPokemons: [RowItem<SearchTabRowItemType, Pokemon>] = [RowItem<SearchTabRowItemType, Pokemon>(type: .noData, value: Pokemon())]
    
    func fetchPokemonList() {
        RestManager.requestObservable(url: RestEndpoints.pokemonList.endpoint(), dataType: PokemonListResponse.self)
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
    
    private func createPokemons(from response: PokemonListResponse) -> [RowItem<SearchTabRowItemType, Pokemon>] {
        return response.results
            .enumerated()
            .map { (index, responseItem) in
                RowItem<SearchTabRowItemType, Pokemon>(type: .foundSearchResult,
                                                  value: Pokemon(id: index + 1, // Pokemon id starts with 1
                                                                 name: responseItem.name,
                                                                 url: responseItem.url))
            }
    }
    
    private func createPokemonsWithNoData() -> [RowItem<SearchTabRowItemType, Pokemon>] {
        return [RowItem<SearchTabRowItemType, Pokemon>(type: .noData, value: Pokemon())]
    }
}
