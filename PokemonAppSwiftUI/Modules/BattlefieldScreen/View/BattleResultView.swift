
import SwiftUI

struct BattleResultView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var viewModel: BattleResultViewModel
    
    var body: some View {
        viewModel.createView(presentationMode: presentationMode)
    }
}
