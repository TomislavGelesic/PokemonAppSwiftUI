

import Foundation

struct PokemonItemResponse: Codable {
    var id: Int
    var name: PokemonItemNameResponse
    var base: PokemonItemBaseResponse?
    var imageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, base, imageURL = "hires"
    }
}
