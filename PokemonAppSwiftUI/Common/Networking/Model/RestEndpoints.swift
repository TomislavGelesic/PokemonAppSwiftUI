//

import Foundation

/*
 
 DATA SOURCE INFO LINK:   https://purukitto.github.io/pokemon-api/

 */

public enum RestEndpoints {
    case pokemonList
    case pokemonDetails(Int)
    case randomPokemon
    case pokepediaEndpoint
    
    private static let scheme = "https://"
    private static let apiHost = "app.pokemon-api.xyz/"
    private static let officialHost = "www.pokemon.com/"
    private static let pokemonPath = "pokemon/"
    private static let officialPath = "us/"
    
    private static var list: String {
        return scheme + apiHost + pokemonPath + "all" // gets all - update, make pages
    }
    
    private static var details: String {
        return scheme + apiHost + pokemonPath
    }
    
    private static var random: String {
        return scheme + apiHost + pokemonPath + "random"
    }
    
    private static var pokepedia: String {
        return scheme + officialHost + officialPath
    }
    
    func endpoint() -> String {
        switch self {
        case .pokemonList:
            return RestEndpoints.list
        case .pokemonDetails(let id):
            return RestEndpoints.details + "/\(id)"
        case .randomPokemon:
            return RestEndpoints.random
        case .pokepediaEndpoint:
            return RestEndpoints.pokepedia
        }
    }
}
