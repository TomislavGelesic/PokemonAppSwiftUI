
import SwiftUI

struct SearchFieldView: View {
    
    @Binding var textInput: String
    
    var body: some View {
            HStack {
                TextField("Search", text: $textInput)
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.orange)
            }
            .padding()
            .background(Color.white
                            .opacity(0.95)
                            .cornerRadius(10))
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.orange, lineWidth: 1))
    }
}
