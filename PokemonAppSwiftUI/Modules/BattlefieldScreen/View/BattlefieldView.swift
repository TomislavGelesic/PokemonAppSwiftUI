

import SwiftUI

struct BattlefieldView: View {
    
    var viewModel: BattleFieldViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Image(viewModel.backgroundImageName)
                    .resizable()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .scaledToFill()
                
                VStack() {
                    Text("WILD POKEMONS")
                        .font(.title)
                        .foregroundColor(Color("ThemeForegroundColor"))
                    
                    viewModel.createView(for: .enemyPokemons,
                                         contentWidth: geo.size.width * 0.3)
                    Divider()
                    Spacer()
                    Text("YOUR POKEMONS")
                        .font(.title)
                        .foregroundColor(Color("ThemeForegroundColor"))
                    viewModel.createView(for: .availablePokemons,
                                         contentWidth: geo.size.width * 0.3)
                    Divider()
                    Spacer()
                    Button(action: {
                        //impl fight result scenario
                    }, label: {
                        PokemonTextView(text: "Fight")
                    })
                }
                .padding()
            }
        }
    }
}


