//
//  PokeballLoaderView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 05.08.2021..
//

import SwiftUI

struct PokeballLoaderView: View {
    
    @State private var angle: Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            Image("pokeball")
                .resizable()
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(angle))
                .animation(.interpolatingSpring(mass: 1, stiffness: 10, damping: 1, initialVelocity: 5)
                            .repeatForever(autoreverses: true),
                           value: angle)
                .onAppear(perform:  { angle += 360 })
            Spacer()
            Text("Scanning for available Pokemons...")
                .frame(alignment: .center)
                .foregroundColor(Color("ThemeForegroundColor"))
            Spacer()
        }
    }
}

struct PokeballLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        PokeballLoaderView()
    }
}
