
import Foundation

class PokemonDetails: Codable, Identifiable {
    var id: Int
    var name: String
    var sprites: [String:String]
    
    func getImagePath() -> String? {
        return sprites["front-shiny"]
    }
}

