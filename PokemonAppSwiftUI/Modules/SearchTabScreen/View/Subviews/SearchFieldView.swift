
import SwiftUI

struct SearchFieldView: View {
    
    @Binding var textInput: String
    
    var body: some View {
            HStack {
                TextField("Search", text: $textInput)
                Image(systemName: "magnifyingglass")
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("ThemeForegroundColor"), lineWidth: 3))
    }
}
