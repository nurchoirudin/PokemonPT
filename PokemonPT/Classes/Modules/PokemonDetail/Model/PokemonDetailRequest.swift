//
//  PokemonDetailRequest.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation

struct PokemonDetailRequest {
    var name: String? = ""
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        if let name = name {
            params["name"] = name
        }
        
        return params
    }

}
