//
//  HomeView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 03.08.2021..
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
            TabView {
                DeckTabView()
                    .tabItem { Image(systemName: "house.fill") }
                
                SearchTabView()
                    .tabItem { Image(systemName: "magnifyingglass.circle.fill") }
                
                InDevelopmentView()
                    .tabItem { Image(systemName: "cross.fill") }
                
                InDevelopmentView()
                        .tabItem { Image(systemName: "globe") }
            }
            .accentColor(.orange)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
