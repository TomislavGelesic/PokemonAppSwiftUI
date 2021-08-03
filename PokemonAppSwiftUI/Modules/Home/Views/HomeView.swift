//
//  HomeView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 03.08.2021..
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            TabView {
                DeckTabView()
                    .tabItem { Image(systemName: "house.fill") }
                
                SearchTabView()
                    .tabItem { Image(systemName: "􀒓") }
                
                InDevelopmentView()
                    .tabItem { Image(systemName: "cross.fill") }
                
                InDevelopmentView()
                        .tabItem { Image(systemName: "globe.europe.africa.fill") }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
