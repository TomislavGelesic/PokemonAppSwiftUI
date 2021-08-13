
import SwiftUI

struct HomeTabView: View {
    
    @EnvironmentObject var databaseManager: PokemonDatabaseManager
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 100) {
                    NavigationLink(destination:
                                    PokeBoxView(viewModel:
                                                    PokeboxViewModel(databaseContext: databaseManager.persistentContainer.viewContext)))
                            {
                        Text("Visit PokeBox!")
                            .frame(width: 200, height: 44)
                            .foregroundColor(Color.white)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.orange, lineWidth: 1))
                    }
                    
                    NavigationLink(destination: BattlefieldView()) {
                        Text("Catch new Pokemon!")
                            .frame(width: 200, height: 44)
                            .foregroundColor(Color.white)
                            .background(Color.orange)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.orange, lineWidth: 1))
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(
                Image("ambient_1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea())
        }
    }
}
