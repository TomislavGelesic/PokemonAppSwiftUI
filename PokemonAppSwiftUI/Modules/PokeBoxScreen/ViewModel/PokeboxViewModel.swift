
import CoreData
import SwiftUI

class PokeboxViewModel: ObservableObject {
    
    var databaseContext: NSManagedObjectContext
    @Published var savedPokemons: [Pokemon] = []
    var cnt = 0
    
    init(databaseContext: NSManagedObjectContext) {
        self.databaseContext = databaseContext
    }
}

extension PokeboxViewModel {
    
    func fetchSavedPokemons() {
        let request = NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
        do {
            savedPokemons = try databaseContext
                .fetch(request)
                .map { PokemonDatabaseManager.createPokemon(from: $0) }
        } catch let error {
            print("Error occured: \(error)")
        }
    }
}
