import CoreData
import SwiftUI

class PokeboxViewModel: ObservableObject {
    var databaseContext: NSManagedObjectContext
    @Published var savedPokemons: [PokemonEntity] = []
    var cnt = 0
    
    init(databaseContext: NSManagedObjectContext) {
        self.databaseContext = databaseContext
    }
}

extension PokeboxViewModel {
    func fetchSavedPokemons() {
        let request = NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
        do {
            savedPokemons = try databaseContext.fetch(request)
        } catch let error {
            print("Error occured: \(error)")
        }
    }
    
    func saveContext() {
        if databaseContext.hasChanges {
            do {
                try databaseContext.save()
                fetchSavedPokemons()
            } catch let error {
                print("error occured: \(error)")
            }
        }
    }
    
    func addPokemon() {
        cnt += 1
        let pokemon = PokemonEntity(context: databaseContext)
        pokemon.name = "\(cnt)"
        saveContext()
    }
    
}
