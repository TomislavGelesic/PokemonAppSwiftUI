//

import Foundation

public enum RestEndpoints {
    case pokemonList
    case pokemonDetails(Int)
    case randomPokemon
    
    private static let scheme = "https://"
    private static let host = "app.pokemon-api.xyz/"
    private static let path = "pokemon/"
    
    private static var list: String {
        return scheme + host + path + "all" // gets all - update, make pages
    }
    
    private static var details: String {
        return scheme + host + path
    }
    
    private static var random: String {
        return scheme + host + path + "random"
    }
    
    func endpoint() -> String {
        switch self {
        case .pokemonList:
            return RestEndpoints.list
        case .pokemonDetails(let id):
            return RestEndpoints.details + "/\(id)"
        case .randomPokemon:
            return RestEndpoints.random
        }
    }
}
