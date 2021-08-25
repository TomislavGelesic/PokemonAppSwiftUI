
import SwiftUI

struct SearchTabView: View {
    
    @ObservedObject var viewModel: SearchTabViewModel
    
    @State var isLoading: Bool = false
    @State var searchInput: String = ""
    
    init(viewModel: SearchTabViewModel = .init()) {
        self.viewModel = viewModel
        UINavigationBar.changeAppearance(clear: true)
    }
    #warning("navigation bar items cannot be centered? \n- custom navigationview?")
    var body: some View {
        GeometryReader { geo in
            ZStack {
                PokeballLoaderView()
                    .opacity(viewModel.isLoading ? 1 : 0)
                
                NavigationView {
                    List {
                        ForEach(searchInput.isEmpty ? viewModel.allPokemons : viewModel.pokemons, id: \.id) { rowItem in
                            ZStack {
                                NavigationLink( destination: SearchDetailsView(pokemon: rowItem.value)) { }
                                    .hidden()
                                SearchTabRowItemView(rowItem)
                                    .frame(height: 150)
                                    .foregroundColor(Color("ThemeForegroundColor"))
                                    .background(Color("ThemeBackgroundColor")
                                                    .opacity(0.95)
                                                    .cornerRadius(10))
                            }
                        }
                    }
                    .onAppear(perform: {
                        searchInput.removeAll()
                        viewModel.fetchPokemonList()
                    })
                    .navigationBarItems(leading:
                                            HStack(alignment: .center) {
                                                SearchFieldView(textInput: $searchInput)
                                                    .foregroundColor(Color("ThemeForegroundColor"))
                                                    .background(Color("ThemeBackgroundColor")
                                                                    .opacity(0.95)
                                                                    .cornerRadius(10))
                                                    .padding()
                                                    .onChange(of: searchInput,
                                                              perform: { _ in
                                                                viewModel.searchPokemonList(searchInput)
                                                              })
                                            }
                                            .frame(minWidth: 100, maxWidth: geo.size.width)
                    )                }
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
