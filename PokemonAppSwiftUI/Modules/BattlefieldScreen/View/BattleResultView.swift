
import SwiftUI

struct BattleResultView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var viewModel: BattleResultViewModel
    
    var body: some View {
        createView()
    }
}

extension BattleResultView {
    
    private func createView() -> AnyView {
        if let result = viewModel.result {
            var view: some View {
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        VStack {
                            ZStack {
                                NetworkImageView(imageURL: URL(string: result.enemyPokemon.imagePath),
                                                 placeholderImage: UIImage(named: "pokeball")!)
                                    .frame(width: geo.size.width/2, height: geo.size.width/2)
                                Image("pokeball")
                                    .opacity(result.didWin ? 0.2 : 0)
                            }
                            HStack {
                                Rectangle()
                                    .frame(width: geo.size.width * 0.8, height: 3)
                                    .foregroundColor(result.didWin ? Color.green : Color.red)
                            }
                            NetworkImageView(imageURL: URL(string: result.pokemon.imagePath),
                                             placeholderImage: UIImage(named: "pokeball")!)
                                .frame(width: geo.size.width/2, height: geo.size.width/2)
                        }
                        Spacer()
                        Text(result.didWin ? "VICTORY" : "DEFEAT")
                            .font(.system(size: 32))
                            .foregroundColor(result.didWin ? .green : .red)
                            .border(width: 3,
                                    edges: [.bottom],
                                    color: result.didWin ? .green : .red)
                        Spacer()
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            PokemonTextView("OK")
                        })
                        Spacer()
                    }
                    .position(x: geo.size.width/2, y: geo.size.height/2)
                    .background(Color("ThemeBackgroundColor"))
                }
            }
            return AnyView(view)
        }
        else {
            var view: some View {
                VStack {
                    Spacer()
                    ErrorView(errorType: .recoverable())
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
