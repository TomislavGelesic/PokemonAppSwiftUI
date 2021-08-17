
import SwiftUI

struct PokemonPickerGalleryCardView: View {

    var shouldShowStats: Bool
    var pokemon: Pokemon
    var isSelected: Bool = false
    
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment: .center, spacing: 10) {
                NetworkImageView(imageURL: URL(string: pokemon.imagePath), placeholderImage: UIImage(named: "pokeball")!)
                    .frame(width: geo.size.width * 0.8, height: geo.size.width * 0.8)
                    .padding()
                Text("\(pokemon.name)")
                    .frame(width: geo.size.width)
                    .foregroundColor(Color("ThemeForegroundColor"))
                    .font(.system(size: calculateFontSize(contentWidth: geo.size.width)))
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    .border(width: shouldShowStats ? 3 : 0,
                            edges: [.top, .bottom],
                            color: Color("ThemeForegroundColor"))
                if shouldShowStats {
                    StatsView(attack: "\(pokemon.attack)",
                              defense: "\(pokemon.defense)",
                              hp: "\(pokemon.hp)")
                        .frame(width: geo.size.width)
                }
            }
            .padding(EdgeInsets(top: 5.0, leading: 0.0, bottom: 5.0, trailing: 0.0))
            .background(Color("ThemeBackgroundColor").opacity(0.5))
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color("ThemeBackgroundColor") : Color("ThemeForegroundColor"), lineWidth: 3.0))
        }
    }
    
    private func calculateFontSize(contentWidth: CGFloat) -> CGFloat {
        switch contentWidth {
        case 0.0..<100.0:    return 16.0
        case 100.0..<200.0:  return 18.0
        case 200.0..<400.0:  return 22.0
        default:             return 24.0
        }
    }
}
