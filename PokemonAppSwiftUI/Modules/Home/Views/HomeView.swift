//
//  HomeView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 29.07.2021..
//

import SwiftUI
import PokemonAPI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State private var searchInput: String = ""
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationView {
            List {
                SearchView(textInput: $searchInput)
                    .onChange(of: searchInput, perform: { value in
                        viewModel.fetchPokemonList(searchInput)
                    })
                
                if let data = viewModel.pokemonList {
                    ForEach(data, id: \.id) { pokemon in
                        Text(pokemon.name)
                    }
                }
                else {
                    Text("Sorry, something went wrong")
                        .frame(width: 200, height: 50, alignment: .center)
                        .font(.title)
                }
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
