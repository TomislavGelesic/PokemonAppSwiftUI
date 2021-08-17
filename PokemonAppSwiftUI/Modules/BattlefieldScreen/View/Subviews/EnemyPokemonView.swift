
import SwiftUI

struct EnemyPokemonView: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        VStack(spacing: 10) {
            NetworkImageView(imageURL: URL(string: pokemon.imagePath), placeholderImage: UIImage(named: "pokeball")!)
                .frame(width: 100, height: 100)
            Text(pokemon.name)
        }
        .frame(width: 100, height: 100)
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.orange, lineWidth: 5))
    }
}
