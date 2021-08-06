
import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
            TabView {
                HomeTabView()
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

