

import SwiftUI

struct PokemonTextView: View {
    var text: String
    var body: some View {
        Text(text)
            .frame(width: 200, height: 44)
            .foregroundColor(Color.white)
            .background(Color.orange)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.orange, lineWidth: 1))
    }
}
