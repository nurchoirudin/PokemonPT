//
//  PokemonListModel.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
// MARK: - PokemonList
struct PokemonListModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Result]?
    
    // MARK: - Result
    struct Result: Codable {
        let name: String?
        let url: String?
        
        func getPokemonImageOriginal() -> String {
            guard let url = self.url else { return ""}
            let pokemonId = Int("\(url.replacingOccurrences(of:"https://pokeapi.co/api/v2/pokemon/", with: "").dropLast())")
            let pathUrl = String(format: "%03d", pokemonId ?? 0)
            return "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/\(pathUrl).png"
        }
    }
}
