
import SwiftUI

struct SearchTabView: View {
    
    @ObservedObject var viewModel: SearchTabViewModel
    @State private var searchInput: String = ""
    
    init(viewModel: SearchTabViewModel = .init()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                List {
                    SearchView(textInput: $searchInput)
                        .onChange(of: searchInput, perform: { value in
                            viewModel.searchPokemonList(searchInput)
                        })
                        .frame(width: geo.size.width * 0.9,
                               height: 50)
                    
                    ForEach(searchInput.isEmpty ? viewModel.allPokemons : viewModel.pokemons, id: \.value.id) { rowItem in
                        NavigationLink( destination: DeckDetailsView(id: rowItem.value.id)) {
                            SearchTabRowView(rowItem)
                        }
                    }
                }
                .frame(alignment: .center)
                .listStyle(PlainListStyle())
                .navigationBarTitle(Text("I choose you!"), displayMode: .inline)
                .onAppear(perform: {
                    viewModel.fetchPokemonList()
                })
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabView()
    }
}
