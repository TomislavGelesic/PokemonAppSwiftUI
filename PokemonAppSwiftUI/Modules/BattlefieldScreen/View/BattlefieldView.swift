

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
                    Spacer()
                    viewModel.createView(for: .enemyPokemons,
                                         contentWidth: geo.size.width * 0.9)
                    Spacer()
                    viewModel.createView(for: .availablePokemons,
                                         contentWidth: geo.size.width * 0.9)
                    Spacer()
                }
                .padding()
            }
        }
    }
}


