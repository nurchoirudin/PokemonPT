//
//  NetworkConfiguration.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum ImageMovieType {
    case poster, backdrop, avatar
}

struct NetworkConfiguration {
    static let BASE_URL = "https://pokeapi.co/api/"
    static let apiPath = "v2/"
    
    static let kTokenExpiredErrorCode = 405
    static let kGatewayTimeoutErrorCode = 503
    static let kMissingPhoneNumberErrorCode = 403
    
    static var envBaseUrl: String = {
        return BASE_URL
    }()
    
    static var apiVersion: String = {
        return apiPath
    }()
    
    static func api(_ apiType: APIUrl) -> String {
        return envBaseUrl + apiVersion + apiType.apiString()
    }
}
