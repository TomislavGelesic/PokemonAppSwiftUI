//
//  SearchDetailsStatsView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 06.08.2021..
//

import SwiftUI

struct StatsView: View {
    var attack: String = "undefined"
    var defense: String = "undefined"
    var hp: String = "undefined"
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: 30) {
                Text("Attack:")
                Text("Defense:")
                Text("Health points:")
            }
            .font(.system(size: 20))
            Spacer()
            VStack(alignment: .trailing, spacing: 30) {
                Text(attack)
                Text(defense)
                Text(hp)
            }
            .font(.system(size: 22))
            Spacer()
        }
        .foregroundColor(Color.orange)
    }
}
