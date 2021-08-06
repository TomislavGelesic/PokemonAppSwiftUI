//
//  DeckTabBackgroundImage.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 03.08.2021..
//

import SwiftUI

struct DeckTabBackgroundImage: View {
    var image: Image = Image(systemName: "applelogo")
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
    }
}

struct DeckTabBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        DeckTabBackgroundImage()
    }
}
