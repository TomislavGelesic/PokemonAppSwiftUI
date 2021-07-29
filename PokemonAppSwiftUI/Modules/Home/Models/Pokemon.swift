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
}
