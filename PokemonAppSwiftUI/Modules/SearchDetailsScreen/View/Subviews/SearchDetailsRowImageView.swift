//
//  SearchDetailsRowItemView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 06.08.2021..
//

import SwiftUI

struct SearchDetailsRowImageView: View {
    
    var imageURL: String
    
    var body: some View {
        NetworkImageView(imageURL: URL(string: imageURL), placeholderImage: UIImage(named: "pokeball")!)
    }
}
