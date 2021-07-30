//
//  HomeDetailsView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 30.07.2021..
//

import SwiftUI

struct HomeDetailsView: View {
    var viewModel: HomeDetailsViewModel
    
    init(id: Int, viewModel: HomeDetailsViewModel? = nil) {
        if let vm = viewModel {
            self.viewModel = vm
        } else {
            self.viewModel = HomeDetailsViewModel(pokemonID: id)
        }
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

struct HomeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailsView(id: 1)
    }
}
