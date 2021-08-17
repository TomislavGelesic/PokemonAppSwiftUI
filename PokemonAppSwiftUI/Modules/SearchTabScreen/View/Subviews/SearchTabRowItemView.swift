
import SwiftUI

struct SearchTabRowItemView: View {
    
    var id: Int = -1
    var text: String = ""
    var imageURL: String = ""
    
    init(_ rowItem: RowItem<SearchTabRowItemType, Pokemon> = .init(type: .noData, value: Pokemon())) {
        configure(rowItem)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack(spacing: 20) {
                    NetworkImageView(imageURL: URL(string: self.imageURL), placeholderImage: UIImage(named: "pokeball")!)
                        .frame(width: geo.size.height * 0.8, height: geo.size.height * 0.8)
                    Text("\(self.text)")
                        .font(.subheadline)
                }
                .padding()
            }
        }
    }
    
    private mutating func configure(_ item: RowItem<SearchTabRowItemType, Pokemon>) {
        switch item.type {
        case .foundSearchResult:
            var name = item.value.name
            name.capitalizeFirstLetter()
            self.text = "\(name)"
            self.imageURL = item.value.imagePath
        case .noSearchResult:
            self.text = "Not found, is this new Pokemon?"
        case .noData:
            self.text = "Sorry, something went wrong."
        }
    }
}

struct HomeRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabRowItemView()
    }
}
