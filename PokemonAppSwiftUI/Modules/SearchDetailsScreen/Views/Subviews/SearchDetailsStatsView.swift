//
//  SearchDetailsStatsView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 06.08.2021..
//

import SwiftUI

struct SearchDetailsStatsView: View {
    var attack: String = "undefined"
    var defense: String = "undefined"
    var hp: String = "undefined"
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 10) {
                Text("Attack:")
                Text("Defense:")
                Text("Health points:")
            }
            Spacer()
            VStack(spacing: 10) {
                Text(attack)
                Text(defense)
                Text(hp)
            }
            Spacer()
        }
        .foregroundColor(Color.orange)
    }
}
