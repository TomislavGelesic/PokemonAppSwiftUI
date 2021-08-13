
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
    
    func saveContext() {
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
}
