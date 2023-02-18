//
//  ResponseError.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation

struct ResponseError: Codable {
    let errors: [ErrorModel]?
    
    struct ErrorModel: Codable, Error {
        let title: String?
        let detail: String?
        let code: String?
        let status: Int?
    }
}
