//
//  PokeBoxCardView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 10.08.2021..
//

import SwiftUI

struct PokeBoxCardView: View {
    
    var pokemon: PokemonEntity

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            NetworkImage(imageURL: URL(string: pokemon.imagePath ?? ""), placeholderImage: UIImage(named: "pokeball")!)
            Text("\(pokemon.name ?? "")")
                .foregroundColor(.orange)
                .font(.system(size: 24))
            StatsView(attack: "\(pokemon.attack)",
                      defense: "\(pokemon.defense)",
                      hp: "\(pokemon.hp)")
        }
        .padding()
        .background(Color.orange.opacity(0.2))
        .cornerRadius(20)
    }
}
