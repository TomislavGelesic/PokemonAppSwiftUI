
import SwiftUI

class SearchDetailsViewModel {
    
    @Published var screenData: [RowItem<SearchDetailsRowType, Any?>] = [RowItem<SearchDetailsRowType, Any?>(type: .noData, value: nil)]
    
    init(pokemon: Pokemon) {
        screenData = createScreenData(from: pokemon)
    }
    
    private func createScreenData(from pokemon: Pokemon) -> [RowItem<SearchDetailsRowType, Any?>] {
        var newScreenData = [RowItem<SearchDetailsRowType, Any?>]()
        newScreenData.append(.init(id: UUID(), type: .image, value: pokemon.imageUrl))
        newScreenData.append(.init(id: UUID(), type: .title, value: pokemon.name))
        newScreenData.append(.init(id: UUID(), type: .stats, value: createSearchDetailsStats(from: pokemon)))
        return newScreenData
    }
    
    private func createSearchDetailsStats(from pokemon: Pokemon) -> SearchDetailsStats {
        return SearchDetailsStats(id: pokemon.id,
                                  attack: pokemon.attack,
                                  defense: pokemon.defense,
                                  hp: pokemon.hp)
    }
    
    func getPokemonName() -> String? {
        return screenData[1].value as? String
    }
    
    func createRowView(for rowItem: RowItem<SearchDetailsRowType, Any?>, width: CGFloat) -> AnyView {
        switch rowItem.type {
        case .image:
            var view: some View {
                NetworkImage(imageURL: URL(string: rowItem.value as? String ?? ""),
                             placeholderImage: UIImage(named: "pokeball")!)
                    .frame(width: width * 2/3, height: width * 2/3, alignment: .center)
            }
            return AnyView(view)
        case .title:
            var view: some View  {
                Text(rowItem.value as? String ?? "")
                    .font(.title)
                    .foregroundColor(Color.orange)
                    .frame(width: width)
                    .multilineTextAlignment(.center)
            }
            return AnyView(view)
        case .stats:
            guard let stats = rowItem.value as? SearchDetailsStats else {
                var view: some View {
                    SearchDetailsStatsView()
                        .frame(width: width)
                        .multilineTextAlignment(.center)
                }
                return AnyView(view)
            }
            var view: some View {
                SearchDetailsStatsView(attack: "\(stats.attack)", defense: "\(stats.defense)", hp: "\(stats.hp)")
                    .frame(width: width)
                    .multilineTextAlignment(.center)
            }
            return AnyView(view)
        case .noData:
            let view = ErrorView()
            return AnyView(view)
        }
    }
}
