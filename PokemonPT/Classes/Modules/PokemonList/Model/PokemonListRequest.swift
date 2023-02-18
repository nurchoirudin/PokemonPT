//
//  PokemonListRequest.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation

struct PokemonListRequest {
    var offset: Int? = 0
    var limit: Int? = 40
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        if let offset = offset {
            params["offset"] = offset
        }
        
        if let limit = limit {
            params["limit"] = limit
        }
        
        return params
    }

}
