
import SwiftUI
import CoreData

class PokemonDatabaseManager: ObservableObject {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonDatabase")
        container.loadPersistentStores { (description, error) in
            if let error = error { print("Error: \(error)") }
        }
        return container
    }()
    
    func save(pokemon: Pokemon) {
        if let savedItems = PokemonDatabaseManager.fetchSavedPokemons(databaseContext: persistentContainer.viewContext),
           !savedItems.contains(where: { $0.name == pokemon.name }) {
            let _ = PokemonDatabaseManager.createPokemonEntity(from: pokemon, inContext: persistentContainer.viewContext)
            saveContext()
        }
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func createPokemon(from entity: PokemonEntity) -> Pokemon {
        var pokemon = Pokemon()
        pokemon.name = entity.name ?? ""
        pokemon.id = Int(entity.id)
        pokemon.attack = Int(entity.attack)
        pokemon.defense = Int(entity.defense)
        pokemon.hp = Int(entity.hp)
        pokemon.imagePath = entity.imagePath ?? ""
        return pokemon
    }
    
    static func createPokemonEntity(from pokemon: Pokemon, inContext: NSManagedObjectContext) -> PokemonEntity {
        let entity = PokemonEntity(context: inContext)
        entity.id = Int16(pokemon.id)
        entity.name = pokemon.name
        entity.attack = Int16(pokemon.attack)
        entity.defense = Int16(pokemon.defense)
        entity.hp = Int16(pokemon.hp)
        entity.imagePath = pokemon.imagePath
        return entity
    }
    
    static func fetchSavedPokemons(databaseContext: NSManagedObjectContext) -> [PokemonEntity]? {
        let request = NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
        do {
            return try databaseContext.fetch(request)
        } catch let error {
            print("Error occured: \(error)")
            return nil
        }
    }
}
