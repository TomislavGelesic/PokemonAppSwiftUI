
import SwiftUI

struct PokepediaView: View {
    var body: some View {
        VStack {
            WebView(url: URL(string: RestEndpoints.pokepediaEndpoint.endpoint()))
        }
    }
}

struct PokepediaView_Previews: PreviewProvider {
    static var previews: some View {
        PokepediaView()
    }
}
