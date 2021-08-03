//
//  DeckTabView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 03.08.2021..
//

import SwiftUI

struct DeckTabView: View {
    
    @State private var backgroundImage: DeckTabBackgroundImage = DeckTabBackgroundImage(image: Image("ambient_1"))
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("deckview")
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .background(backgroundImage)
        }.ignoresSafeArea()
    }
}

struct DeckTabView_Previews: PreviewProvider {
    static var previews: some View {
        DeckTabView()
    }
}
