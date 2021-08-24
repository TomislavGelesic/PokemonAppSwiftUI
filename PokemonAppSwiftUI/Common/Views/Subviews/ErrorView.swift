

import SwiftUI

struct ErrorView: View {
    var errorType: ErrorType
    
    var body: some View {
        createView(for: errorType)
    }
    
    func createView(for type: ErrorType) -> AnyView {
        switch type {
        case .general:
            var view: some View {
                Text("Something went really bad, please report!")
            }
            return AnyView(view)
        case .noInternet:
            var view: some View {
                Text("No internet error occured!")
            }
            return AnyView(view)
        case .recoverable:
            var view: some View {
                Text("Something went wrong.\nTry to re-enter screen!")
            }
            return AnyView(view)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorView(errorType: .general())
            ErrorView(errorType: .noInternet())
            ErrorView(errorType: .recoverable())
        }
    }
}
