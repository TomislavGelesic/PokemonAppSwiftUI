
import SwiftUI
import Kingfisher
import UIKit

public struct NetworkImageView: SwiftUI.View {
    
    @State private var image: UIImage? = nil
    
    public let imageURL: URL?
    public let placeholderImage: UIImage
    public let animation: Animation = .default
    
    public var body: some SwiftUI.View {
        Image(uiImage: image ?? placeholderImage)
            .resizable()
            .onAppear(perform: loadImage)
            .transition(.opacity)
            .id(image ?? placeholderImage)
            .cornerRadius(5.0)
    }
    
    private func loadImage() {
        guard let imageURL = imageURL, image == nil else { return }
        KingfisherManager.shared.retrieveImage(with: imageURL) { result in
            switch result {
            case .success(let imageResult):
                withAnimation(self.animation) {
                    self.image = imageResult.image
                }
            case .failure:
                break
            }
        }
    }
}

struct NetworkImage_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        NetworkImageView(imageURL: URL(string: "https://www.apple.com/favicon.ico")!,
                     placeholderImage: UIImage(systemName: "bookmark")!)
    }
}
