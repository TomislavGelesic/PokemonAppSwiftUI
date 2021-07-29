//
//  RestEndpoints.swift
//  NewsReaderSwiftUI
//
//  Created by Tomislav Gelesic on 17.07.2021..
//

import Foundation

public enum RestEndpoints {
    case pokemonList
    case pokemonDetails(Int)

    private static let scheme = "https://"
    private static let host = "pokeapi.co/"
    private static let path = "api/v2/pokemon"
    
    private static var list: String {
        return scheme + host + path + "?limit=1118" // gets all - update, make pages
    }
    private static var details: String {
        return scheme + host + path
    }
    
    public func endpoint() -> String {
        switch self {
        case .pokemonList:
            return RestEndpoints.list
        case .pokemonDetails(let id):
            return RestEndpoints.details + "/\(id)"
        }
    }
}
