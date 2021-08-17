
import SwiftUI

struct PokeBoxView: View {
    
    @StateObject var viewModel: PokeboxViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                #warning("CoreData update rerendering UI - Is this ok?")
                /*
                 
                 Is 'this' heavy/expensive in 'optimisation' parameters?
                 
                 
                 I needed horizontal list - made it this way.
                 But to re-render items when CoreData database changes
                 I had to conform viewModel and impl as ObservableObject which re-renders ui whenever state in viewmodel changes??
                 Is this heavy/expensive in 'optimisation' parameters?
                 
                 As stated on link, it is bad practice? (comment 2 on link)
                 LINK: https://stackoverflow.com/questions/57340575/binding-and-foreach-in-swiftui
                 
                 */
                PokemonPickerGalleryView(contentWidth: geo.size.width * 0.9,
                                         isSelectable: false,
                                         pokemons: viewModel.savedPokemons) { _ in }
                    .onAppear(perform: viewModel.fetchSavedPokemons)
                    .frame(width: geo.size.width)
                Spacer()
            }
        }
    }
}
