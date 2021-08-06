
import SwiftUI

struct SearchDetailsView: View {
    
    var viewModel: SearchDetailsViewModel
    
    init(viewModel: SearchDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geo in
            List {
                ForEach(viewModel.screenData, id: \.id) { rowItem in
                    HStack {
                    viewModel.createRowView(for: rowItem,
                                            width: geo.size.width)
                    }
                    .frame(width: geo.size.width * 0.9, alignment: .center)
                }
            }
        }
        .navigationTitle(Text(viewModel.getPokemonName() ?? ""))
    }
    
}
