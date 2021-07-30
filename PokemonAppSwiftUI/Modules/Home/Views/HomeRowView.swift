//
//  HomeRowView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 29.07.2021..
//

import SwiftUI

struct HomeRowView: View {
    
    var text: String = ""
    
    init(_ rowItem: RowItem<HomeRowItemType, Pokemon> = .init(type: .noData, value: Pokemon())) {
        configure(rowItem)
    }
    
    var body: some View {
        Text("\(text)")
            .frame(width: 200, height: 50, alignment: .leading)
            .font(.title)
    }
    
    private mutating func configure(_ item: RowItem<HomeRowItemType, Pokemon>) {
        switch item.type {
        case .foundSearchResult:
            var name = item.value.name
            name.capitalizeFirstLetter()
            text = "\(name)"
        case .noSearchResult:
            text = "Not found, is this new Pokemon?"
        case .noData:
            text = "Sorry, something went wrong."
        }
    }
}

struct HomeRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRowView()
    }
}
