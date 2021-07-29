//
//  HomeViewModel.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 29.07.2021..
//

import SwiftUI
import Combine
import Alamofire
import PokemonAPI

class HomeViewModel: ObservableObject {
    
    @Published var pokemonList: [Pokemon]?
    @Published var pokemonDetails: PokemonDetails?
    
    init(pokemonList: [Pokemon] = .init()) {
        self.pokemonList = pokemonList
    }
    
    func fetchPokemonList(_ inputSearch: String) {
        RestManager.requestObservable(url: RestEndpoints.pokemonList.endpoint(), dataType: PokemonListResponse.self)
            .map { result -> [Pokemon]? in
                switch result {
                case .success(let response):
                    let t = response.results
                        .map({ self.createPokemon(from: $0) })
                        .filter { $0.name.localizedCaseInsensitiveContains(inputSearch) }
                    return t
                case .failure(_):
                    return nil
                }
            }
            .assign(to: &$pokemonList)
    }
    
    func fetchDetailsFor(id: Int) {
        RestManager.requestObservable(url: RestEndpoints.pokemonDetails(id).endpoint(),
                                      dataType: PokemonDetails.self)
            .map { result -> PokemonDetails? in
                switch result {
                case .success(let details): return details
                case .failure(_): return nil
                }
            }
            .assign(to: &$pokemonDetails)
    }
    
    func createPokemon(from responseItem: PokemonItemResponse) -> Pokemon {
        return Pokemon(id: 1, name: responseItem.name, url: responseItem.url)
    }
}
