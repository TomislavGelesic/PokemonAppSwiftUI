

import SwiftUI

struct PokemonTextView: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .frame(width: 200, height: 44)
            .foregroundColor(Color("ThemeForegroundColor"))
            .background(Color("ThemeBackgroundColor"))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("ThemeForegroundColor"), lineWidth: 3))
    }
}
