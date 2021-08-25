

import SwiftUI

struct BattlefieldView: View {
    
    let backgroundImageName: String = "battlefield_backgroundImage"
    @StateObject var viewModel: BattleFieldViewModel
    @State private var isShowingBattleResult: Bool = false
    @State private var fightButtonText: String = "Select Pokemons"
    @State private var lightningAnimationFinished: Bool = false
    
    var body: some View {
        createView(state: viewModel.state)
    }
    
    private func createView(state: BattlefieldState) -> AnyView {
        switch state.status {
        case .idle:
            var view: some View {
                GeometryReader { geo in
                    ZStack{
                        Image(backgroundImageName)
                            .resizable()
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                            .scaledToFill()
                        
                        VStack() {
                            Text("WILD POKEMONS")
                                .font(.title)
                                .foregroundColor(Color("ThemeForegroundColor"))
                            createPokemonPickerGalleryView(state: viewModel.state,
                                                           pokemonType: .enemyPokemons,
                                                           contentWidth: geo.size.width * 0.3)
                            Divider()
                            Spacer()
                            Text("YOUR POKEMONS")
                                .font(.title)
                                .foregroundColor(Color("ThemeForegroundColor"))
                            createPokemonPickerGalleryView(state: viewModel.state,
                                                           pokemonType: .availablePokemons,
                                                           contentWidth: geo.size.width * 0.3)
                            Divider()
                            Spacer()
                            Button(
                                action: {
                                    viewModel.sendEvent(.onShowFightResults)
                                    isShowingBattleResult = true
                                    lightningAnimationFinished = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        lightningAnimationFinished = true
                                    }
                                },
                                label: { PokemonTextView(fightButtonText) })
                                .sheet(isPresented: $isShowingBattleResult, content: {
                                    withAnimation(.easeIn(duration: 5.0)) {
                                        ZStack {
                                            LottieView(animationJsonFileName: "lightningAnimation", loopMode: .loop)
                                                .background(Color.black)
                                                .opacity(lightningAnimationFinished ? 0.0 : 1.0)
                                            
                                            BattleResultView(viewModel: BattleResultViewModel(viewModel.state.battleResult, onDismiss: {
                                                viewModel.sendEvent(.onAppear)
                                                isShowingBattleResult = false
                                            }))
                                            .opacity(lightningAnimationFinished ? 1.0 : 0.0)
                                            
                                        }
                                    }
                                })
                                .disabled(!viewModel.state.canFight())
                        }
                        .padding()
                    }
                }
            }
            return AnyView(view)
        case .loading:
            var view: some View {
                PokeballLoaderView()
            }
            return AnyView(view)
        case .error(let errorType):
            var view: some View {
                ErrorView(errorType: errorType)
            }
            return AnyView(view)
        }
    }
    
    private func createPokemonPickerGalleryView(state: BattlefieldState, pokemonType type: BattlefieldRowItemType, contentWidth width: CGFloat) -> AnyView {
        let filteredData = state.screenData.filter { $0.type == type }
        for item in filteredData {
            switch item.type {
            case .availablePokemons:
                guard let availablePokemons = item.value as? [Pokemon],
                      !availablePokemons.isEmpty
                else {
                    viewModel.sendEvent(.onOccuredError(.recoverable()))
                    return AnyView(EmptyView())
                }
                var view: some View {
                    PokemonPickerGalleryView(contentWidth: width,
                                             shouldShowStats: false,
                                             isSelectable: true,
                                             pokemons: availablePokemons,
                                             onSelection: { index in
                                                viewModel.state.selectedPokemon = nil
                                                if index >= 0 {
                                                    viewModel.sendEvent(.onSelectPokemon(item.type, availablePokemons[index]))
                                                }
                                                if viewModel.state.canFight() { fightButtonText = "Fight" }
                                                else { fightButtonText = "Select Pokemon" }
                                             })
                    
                }
                return AnyView(view)
            case .enemyPokemons:
                guard let enemyPokemons = item.value as? [Pokemon]
                else {
                    viewModel.sendEvent(.onOccuredError(.recoverable()))
                    return AnyView(EmptyView())
                }
                var view: some View {
                    PokemonPickerGalleryView(contentWidth: width,
                                             shouldShowStats: false,
                                             isSelectable: true,
                                             pokemons: enemyPokemons,
                                             onSelection: { index in
                                                viewModel.state.selectedEnemyPokemon = nil
                                                if index >= 0 {
                                                    viewModel.sendEvent(.onSelectPokemon(item.type, enemyPokemons[index]))
                                                }
                                                if viewModel.state.canFight() { fightButtonText = "Fight" }
                                                else { fightButtonText = "Select Pokemon" }
                                             })
                }
                return AnyView(view)
            case .empty:
                var view: some View {
                    Text(item.value as? String ?? "No data.")
                }
                return AnyView(view)
            }
        }
        viewModel.sendEvent(.onOccuredError(.recoverable()))
        return AnyView(EmptyView())
    }
}


