
import SwiftUI
import CoreData

@main
struct PokemonAppSwiftUIApp: App {
    
    @StateObject var pokemonDatabaseManager: PokemonDatabaseManager = .init()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(pokemonDatabaseManager)
                .onAppear(perform: {
                    setStartingPokemons()
                })
        }
    }
}

extension PokemonAppSwiftUIApp {
    
    private func setStartingPokemons() {
        pokemonDatabaseManager.save(pokemon: createPikachu())
    }
    
    private func createPikachu() -> Pokemon {
        return Pokemon(id: 25, name: "Pikachu", hp: 35, attack: 55, defense: 40,
                       imageUrl: "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/master/images/pokedex/hires/025.png")
    }
}
