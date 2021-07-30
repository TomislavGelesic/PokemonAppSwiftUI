//
//  Pokemon.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 29.07.2021..
//

import Foundation

struct Pokemon: Codable, Identifiable {
    var id: Int
    var name: String
    var url: String
    
    init(id: Int = -1, name: String = "-1", url: String = "-1") {
        self.id = id
        self.name = name
        self.url = url
    }
}
