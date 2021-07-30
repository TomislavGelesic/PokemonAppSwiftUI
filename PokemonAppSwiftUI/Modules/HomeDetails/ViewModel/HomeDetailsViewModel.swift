//
//  HomeDetailsViewModel.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 30.07.2021..
//

import SwiftUI

class HomeDetailsViewModel {
    
    @Published var pokemonDetails: PokemonDetails?
    
    var id: Int
    
    init(pokemonID: Int) {
        self.id = pokemonID
    }
    
    private func fetchDetailsFor(id: Int) {
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
}
