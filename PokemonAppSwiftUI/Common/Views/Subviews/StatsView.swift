
import SwiftUI

struct StatsView: View {
    var attack: String = "undefined"
    var defense: String = "undefined"
    var hp: String = "undefined"
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                Text("Attack:")
                Text("Defense:")
                Text("Health points:")
            }
            .font(.system(size: 20))
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                Text(attack)
                Text(defense)
                Text(hp)
            }
            .font(.system(size: 22))
            Spacer()
        }
        .lineLimit(2)
        .foregroundColor(Color("ThemeForegroundColor"))
        .padding()
    }
}
