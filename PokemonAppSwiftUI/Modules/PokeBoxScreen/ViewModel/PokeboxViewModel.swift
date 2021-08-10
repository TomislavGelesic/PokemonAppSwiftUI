import CoreData
import SwiftUI

class PokeboxViewModel {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    private var items: FetchedResults<PokemonDataBaseItem>
    
    var screenData: [RowItem<PokeBoxRowType, Pokemon>] = [
        RowItem<PokeBoxRowType, Pokemon>(id: UUID(), type: .boxItem, value: Pokemon()),
        RowItem<PokeBoxRowType, Pokemon>(id: UUID(), type: .boxItem, value: Pokemon()),
        RowItem<PokeBoxRowType, Pokemon>(id: UUID(), type: .boxItem, value: Pokemon())
    ]
    
    private func addPokemon(_ pokemon: Pokemon) {
        withAnimation {
            _ = PokemonDatabaseItem(context: viewContext)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
