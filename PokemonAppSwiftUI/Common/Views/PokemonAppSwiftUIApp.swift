
import SwiftUI

@main
struct PokemonAppSwiftUIApp: App {
    @StateObject var pokemonDatabaseManager: PokemonDatabaseManager = .init()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(pokemonDatabaseManager)
        }
    }
}
