
import SwiftUI

struct PokeBoxCardView: View {
    
    var shouldShowStats: Bool
    var pokemon: Pokemon
    var isSelected: Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment: .center, spacing: 30) {
                NetworkImage(imageURL: URL(string: pokemon.imagePath), placeholderImage: UIImage(named: "pokeball")!)
                    .frame(width: geo.size.width * 0.7, height: geo.size.width * 0.7)
                Text("\(pokemon.name)")
                    .foregroundColor(.orange)
                    .font(.system(size: 24))
                if shouldShowStats {
                    StatsView(attack: "\(pokemon.attack)",
                              defense: "\(pokemon.defense)",
                              hp: "\(pokemon.hp)")
                }
            }
            .padding()
            .background(Color.orange.opacity(0.2))
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.orange, lineWidth: isSelected ? 5.0 : 0.0))
        }
    }
}
