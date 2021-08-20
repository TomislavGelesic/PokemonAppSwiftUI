

import SwiftUI

struct BattlefieldView: View {
    
    var viewModel: BattleFieldViewModel
    @State private var isShowingBattleResult: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Image(viewModel.backgroundImageName)
                    .resizable()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .scaledToFill()
                    .opacity(viewModel.isShowingError || viewModel.isLoading ? 0.4 : 1)
                    .blur(radius: viewModel.isShowingError || viewModel.isLoading ? 30 : 0)
                
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
                        if viewModel.canFight {
                            isShowingBattleResult = true
                        }
                    }, label: {
                        PokemonTextView(viewModel.canFight ? "Fight" : "SelectPokemons")
                    })
                    .sheet(isPresented: $isShowingBattleResult, content: {
                        BattleResultView(viewModel: BattleResultViewModel(viewModel.battleResult))
                    })
                    .onDisappear(perform: {
                        isShowingBattleResult = false
                    })
                }
                .padding()
                .opacity(viewModel.isShowingError || viewModel.isLoading ? 0.0 : 1.0)
                
                ErrorView(errorType: .recoverable)
                    .opacity(viewModel.isShowingError ? 1.0 : 0.0)
                
                PokeballLoaderView()
                    .opacity(viewModel.isLoading ? 1.0 : 0.0)
            }
        }
    }
}


