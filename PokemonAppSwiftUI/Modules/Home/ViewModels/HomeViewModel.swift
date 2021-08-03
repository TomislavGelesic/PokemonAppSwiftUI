//
//  HomeViewModel.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 29.07.2021..
//

import SwiftUI
import Combine
import Alamofire

class HomeViewModel: ObservableObject {
    @Published var pokemons: [RowItem<HomeRowItemType, Pokemon>] = [RowItem<HomeRowItemType, Pokemon>(type: .noData, value: Pokemon())]
    @Published var allPokemons: [RowItem<HomeRowItemType, Pokemon>] = [RowItem<HomeRowItemType, Pokemon>(type: .noData, value: Pokemon())]
    
    func fetchPokemonList() {
        RestManager.requestObservable(url: RestEndpoints.pokemonList.endpoint(), dataType: PokemonListResponse.self)
            .map { [unowned self] result -> [RowItem<HomeRowItemType, Pokemon>] in
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
            filteredList.append(RowItem<HomeRowItemType, Pokemon>(type: .noSearchResult, value: Pokemon()))
        }
        pokemons = filteredList
    }
    
    private func createPokemons(from response: PokemonListResponse) -> [RowItem<HomeRowItemType, Pokemon>] {
        return response.results
            .enumerated()
            .map { (index, responseItem) in
                RowItem<HomeRowItemType, Pokemon>(type: .foundSearchResult,
                                                  value: Pokemon(id: index + 1, // Pokemon id starts with 1
                                                                 name: responseItem.name,
                                                                 url: responseItem.url))
            }
    }
    
    private func createPokemonsWithNoData() -> [RowItem<HomeRowItemType, Pokemon>] {
        return [RowItem<HomeRowItemType, Pokemon>(type: .noData, value: Pokemon())]
    }
}
