
import SwiftUI

struct SearchTabView: View {
    
    @ObservedObject var viewModel: SearchTabViewModel
    
    @State var angle: Double = 0
    @State var isLoading: Bool = false
    @State var searchInput: String = ""
    
    init(viewModel: SearchTabViewModel = .init()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("pokeball")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(angle))
                    .animation(.interpolatingSpring(mass: 1, stiffness: 10, damping: 1, initialVelocity: 5)
                                .repeatForever(autoreverses: true),
                               value: angle)
                    .onAppear(perform:  {
                        angle += 360
                        
                    })
                    .opacity(viewModel.isLoading ? 1 : 0)
                
                NavigationView {
                    ZStack {
                        List {
                            ForEach(searchInput.isEmpty ? viewModel.allPokemons : viewModel.pokemons, id: \.value.id) { rowItem in
                                NavigationLink( destination: DeckDetailsView(id: rowItem.value.id)) {
                                    SearchTabRowView(rowItem,
                                                     width: geo.size.width,
                                                     height: 150)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .navigationBarTitle(Text("I choose you!"), displayMode: .inline)
                        .onAppear(perform: {
                            viewModel.fetchPokemonList()
                        })
                        VStack {
                            SearchView(textInput: $searchInput)
                                .onChange(of: searchInput, perform: { _ in viewModel.searchPokemonList(searchInput) })
                                .frame(width: geo.size.width * 0.9, height: 50)
                                .padding(EdgeInsets(top: 10.0, leading: 0.0, bottom: 10.0, trailing: 0.0))
                                .background(Color.white.opacity(0.95))
                            
                            Spacer()
                        }
                    }
                }
                .opacity(viewModel.isLoading ? 0.4 : 1)
                .blur(radius: viewModel.isLoading ? 30 : 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabView()
    }
}
