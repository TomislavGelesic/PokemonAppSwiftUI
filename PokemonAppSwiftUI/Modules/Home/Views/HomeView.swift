//
//  HomeView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 29.07.2021..
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State private var searchInput: String = ""
    
    init(viewModel: HomeViewModel = .init()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                List {
                    SearchView(textInput: $searchInput)
                        .onChange(of: searchInput, perform: { value in
                            viewModel.searchPokemonList(searchInput)
                        })
                        .frame(width: geo.size.width * 0.9,
                               height: 50)
                    
                    ForEach(searchInput.isEmpty ? viewModel.allPokemons : viewModel.pokemons, id: \.value.id) { rowItem in
                        NavigationLink( destination: HomeDetailsView(id: rowItem.value.id)) {
                            HomeRowView(rowItem)
                        }
                    }
                }
                .frame(alignment: .center)
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text("I choose you!"), displayMode: .inline)
                .onAppear(perform: {
                    viewModel.fetchPokemonList()
                })
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
