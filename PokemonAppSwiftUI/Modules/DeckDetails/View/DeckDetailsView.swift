//
//  DeckDetailsView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 30.07.2021..
//

import SwiftUI

struct DeckDetailsView: View {
    var viewModel: DeckDetailsViewModel
    
    init(id: Int, viewModel: DeckDetailsViewModel? = nil) {
        if let vm = viewModel {
            self.viewModel = vm
        } else {
            self.viewModel = DeckDetailsViewModel(pokemonID: id)
        }
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

struct DeckDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DeckDetailsView(id: 1)
    }
}
