

import SwiftUI

struct BattlefieldView: View {
    
    var viewModel: BattleFieldViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Image(viewModel.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                
                VStack(spacing: 20) {
                    viewModel.createView(for: .enemyPokemons)
                    viewModel.createView(for: .availablePokemons)
                }
            }
        }
    }
}


