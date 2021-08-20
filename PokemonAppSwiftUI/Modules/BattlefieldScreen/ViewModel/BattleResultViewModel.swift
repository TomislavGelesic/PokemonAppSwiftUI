
import SwiftUI

class BattleResultViewModel {
    
    var result: BattleResult?
    
    init(_ result: BattleResult?) {
        self.result = result
    }
    
    func createView(presentationMode: Binding<PresentationMode>) -> AnyView {
        if let result = result {
            var view: some View {
                VStack {
                    HStack {
                        NetworkImageView(imageURL: URL(string: result.pokemon.imagePath),
                                         placeholderImage: UIImage(named: "pokeball")!)
                        PokemonTextView("  vs  ")
                        NetworkImageView(imageURL: URL(string: result.enemyPokemon.imagePath),
                                         placeholderImage: UIImage(named: "pokeball")!)
                    }
                    Spacer()
                    Text(result.didWin ? "Victory" : "Defeat")
                        .font(.system(size: 32))
                        .foregroundColor(result.didWin ? .green : .red)
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        PokemonTextView("OK")
                    })
                    Spacer()
                }
                .background(Color("ThemeBackgroundColor"))
            }
            return AnyView(view)
        }
        else {
            var view: some View {
                VStack {
                    Spacer()
                    ErrorView(errorType: .recoverable)
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        PokemonTextView("OK")
                    })
                    Spacer()
                }
                .background(Color("ThemeBackgroundColor"))
            }
            return AnyView(view)
        }
    }
}
