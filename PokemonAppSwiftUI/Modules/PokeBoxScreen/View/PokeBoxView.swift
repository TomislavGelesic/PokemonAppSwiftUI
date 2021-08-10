
import SwiftUI

struct PokeBoxView: View {
    var viewModel: PokeboxViewModel
    
    init(viewModel: PokeboxViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.screenData, id: \.id) { item in
                        PokeBoxCardView(pokemon: item.value)
                            .frame(width: 300, height: 400)
                    }
                }
                .padding()
            }
            Spacer()
        }
    }
}

struct PokeBoxView_Previews: PreviewProvider {
    static var previews: some View {
        PokeBoxView(viewModel: PokeboxViewModel())
    }
}
