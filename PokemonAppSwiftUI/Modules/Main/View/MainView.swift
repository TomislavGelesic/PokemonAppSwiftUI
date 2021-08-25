
import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            HomeTabView()
                .tabItem { Image(systemName: "house.fill") }
            
            SearchTabView()
                .tabItem { Image(systemName: "magnifyingglass.circle.fill") }
            
            InDevelopmentView()
                .tabItem { Image(systemName: "cross.fill") }
            
            PokepediaView()
                .tabItem { Image(systemName: "globe") }
        }
        .accentColor(Color("ThemeForegroundColor"))
    }    
}

