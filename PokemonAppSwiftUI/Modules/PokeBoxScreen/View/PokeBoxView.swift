
import SwiftUI

struct PokeBoxView: View {
    var viewModel: PokeboxViewModel
    
    var body: some View {
        VStack {
            Button("Add") {
                viewModel.addPokemon()
            }
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.savedPokemons, id: \.self) { savedPokemon in
                        PokeBoxCardView(pokemon: savedPokemon)
                            .frame(width: 300, height: 400)
                    }
                    .padding()
                }
            }.onAppear(perform: viewModel.fetchSavedPokemons)
            Spacer()
        }
    }
}
