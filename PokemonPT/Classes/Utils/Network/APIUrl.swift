//
//  APIUrl.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation

enum APIUrl {
    case getPokemonList(request: PokemonListRequest)
    case getPokemonDetail(request: PokemonDetailRequest)

    func apiString() -> String {
        switch self {
        case .getPokemonList(let request):
            return "pokemon?\(request.getParams().toQueryString())"
        case .getPokemonDetail(let request):
            return "pokemon/\(request.name ?? "")"
        }
    }
    
    func urlString() -> String {
        return NetworkConfiguration.api(self)
    }
}
