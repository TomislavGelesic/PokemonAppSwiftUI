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
            HStack {
                TextField("Search", text: $textInput)
                Image(systemName: "magnifyingglass")
            }
            .padding()
            .border(Color.black, width: 1)
    }
}
