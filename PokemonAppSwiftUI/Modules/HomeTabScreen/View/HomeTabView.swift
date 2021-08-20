
import SwiftUI

struct HomeTabView: View {
    
    @EnvironmentObject var databaseManager: PokemonDatabaseManager
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 100) {
                    NavigationLink(
                        destination: PokeBoxView(viewModel: PokeboxViewModel(databaseContext: databaseManager.persistentContainer.viewContext)),
                        label: {
                            PokemonTextView("Visit PokeBox!")
                        })
                    
                    NavigationLink(
                        destination: BattlefieldView(viewModel: BattleFieldViewModel(databaseContext: databaseManager.persistentContainer.viewContext)),
                        label: {
                            PokemonTextView("Catch new Pokemon!")
                        })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(
                Image("ambient_1")
                    .resizable()
                    .scaledToFill())
            .navigationBarTitle(Text(""), displayMode: .inline)            
        }
    }
}
