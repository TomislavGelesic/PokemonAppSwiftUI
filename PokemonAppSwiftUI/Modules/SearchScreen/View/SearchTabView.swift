
import SwiftUI

struct SearchTabView: View {
    
    @ObservedObject var viewModel: SearchTabViewModel
    
    @State var isLoading: Bool = false
    @State var searchInput: String = ""
    
    init(viewModel: SearchTabViewModel = .init()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                PokeballLoaderView()
                    .opacity(viewModel.isLoading ? 1 : 0)
                
                NavigationView {
                    ZStack {
                        List {
                            ForEach(searchInput.isEmpty ? viewModel.allPokemons : viewModel.pokemons, id: \.value.id) { rowItem in
                                NavigationLink( destination: SearchDetailsView(viewModel: SearchDetailsViewModel(pokemon: rowItem.value))) {
                                    SearchTabRowItemView(rowItem,
                                                         width: geo.size.width,
                                                         height: 150)
                                }
                            }
                        }
                        .navigationBarTitle(Text("Available Pokemons"), displayMode: .inline)
                        .onAppear(perform: {
                            searchInput.removeAll()
                            viewModel.fetchPokemonList()
                        })
                        
                        VStack {
                            Spacer()
                            SearchFieldView(textInput: $searchInput)
                                .onChange(of: searchInput, perform: { _ in viewModel.searchPokemonList(searchInput) })
                                .frame(width: geo.size.width * 0.9, height: 50)
                                .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 3.0, trailing: 0.0))
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
