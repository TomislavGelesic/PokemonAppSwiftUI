//
//  SearchView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 29.07.2021..
//

import SwiftUI

struct SearchView: View {
    
    @Binding var textInput: String
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                TextField("Search", text: $textInput)
                Image(systemName: "magnifyingglass")
            }
            .padding()
            .frame(width: geo.size.width * 0.8, height: 50, alignment: .center)
            .border(Color.black, width: 1)
        }
    }
}
