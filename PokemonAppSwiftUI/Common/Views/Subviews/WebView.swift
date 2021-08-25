
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    
    var url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        guard let url = url else { return view}
        view.load(URLRequest(url: url))
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
//        guard let url = url else { return }
//        uiView.load(URLRequest(url: url))
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "https://www.google.hr/"))
    }
}
