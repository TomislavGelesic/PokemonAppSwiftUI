
import SwiftUI

struct PokemonPickerGalleryView: View {
    
    var contentWidth: CGFloat = 150.0
    var shouldShowStats: Bool = true
    var isSelectable: Bool
    var pokemons: [Pokemon] = .init()
    var onSelection: ((Int)->()) = { _ in }
    @State private var selectedIndex: Int = -1
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<pokemons.count, id: \.self) { i in
                    PokemonPickerGalleryCardView(shouldShowStats: shouldShowStats,
                                                 pokemon: self.pokemons[i],
                                                 isSelected: selectedIndex == i ? true : false)
                        .frame(width: contentWidth)
                        .onTapGesture {
                            if isSelectable {
                                selectedIndex = i
                                onSelection(selectedIndex)
                            }
                        }
                }
                .padding()
            }
        }
    }
}

struct PokemonPickerGallery_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPickerGalleryView(isSelectable: true)
    }
}
