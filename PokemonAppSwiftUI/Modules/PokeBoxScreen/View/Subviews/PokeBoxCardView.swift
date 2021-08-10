//
//  PokeBoxCardView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 10.08.2021..
//

import SwiftUI

struct PokeBoxCardView: View {
    
    var pokemon: Pokemon = .init()
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            NetworkImage(imageURL: URL(string: pokemon.imageUrl), placeholderImage: UIImage(named: "pokeball")!)
            Text("\(pokemon.name)")
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

struct PokeBoxCardView_Previews: PreviewProvider {
    static var previews: some View {
        PokeBoxCardView()
    }
}
