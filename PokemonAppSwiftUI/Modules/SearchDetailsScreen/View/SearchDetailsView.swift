
import SwiftUI

struct SearchDetailsView: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        PokemonPickerGalleryCardView(shouldShowStats: true, pokemon: pokemon)
            .padding()
    }
}
