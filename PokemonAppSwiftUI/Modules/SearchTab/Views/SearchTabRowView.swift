
import SwiftUI

struct SearchTabRowView: View {
    
    var text: String = ""
    var imageURL: String = ""
    var width: CGFloat
    var height: CGFloat
    
    init(_ rowItem: RowItem<SearchTabRowItemType, Pokemon> = .init(type: .noData, value: Pokemon()), width: CGFloat = 200, height: CGFloat = 150) {
        self.width = width
        self.height = height
        configure(rowItem)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            NetworkImage(imageURL: URL(string: imageURL), placeholderImage: UIImage(named: "pokeball")!)
                .frame(width: height - 20, height: height - 20)
            Text("\(text)")
                .frame(width: width - 120, alignment: .leading)
                .font(.title)
        }
        .frame(height: height)
    }
    
    private mutating func configure(_ item: RowItem<SearchTabRowItemType, Pokemon>) {
        switch item.type {
        case .foundSearchResult:
            var name = item.value.name
            name.capitalizeFirstLetter()
            text = "\(name)"
            imageURL = item.value.imageUrl
        case .noSearchResult:
            text = "Not found, is this new Pokemon?"
        case .noData:
            text = "Sorry, something went wrong."
        }
    }
}

struct HomeRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabRowView()
    }
}
