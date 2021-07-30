//
//  PokemonInfo.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 30.07.2021..
//

import Foundation

class PokemonInfo: ObservableObject {
    @Published var list: [RowItem<HomeRowItemType, Pokemon>]
    
    init(list: [RowItem<HomeRowItemType, Pokemon>] = .init()) {
        self.list = list
    }
    
    
}
