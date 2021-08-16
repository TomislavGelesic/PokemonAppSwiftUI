
import SwiftUI

struct PokemonPickerGallery: View {
    
    var shouldShowStats: Bool = true
    var isSelectable: Bool
    var pokemons: [Pokemon] = .init()
    var onSelection: ((Int)->()) = { _ in }
    @State private var selectedIndex: Int = -1
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<pokemons.count, id: \.self) { i in
                        PokeBoxCardView(shouldShowStats: shouldShowStats, pokemon: self.pokemons[i], isSelected: selectedIndex == i ? true : false)
                            .frame(width: geo.size.width * 0.8)
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
}

struct PokemonPickerGallery_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPickerGallery(isSelectable: true)
    }
}
