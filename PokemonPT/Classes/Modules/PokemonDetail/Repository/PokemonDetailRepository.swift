//
//  PokemonDetailRepository.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import RxSwift

class PokemonDetailRepository: PokemonDetailDataSource {
    private let remoteData: NetworkProtocol
    
    init(remoteData: NetworkProtocol) {
        self.remoteData = remoteData
    }
    
    func getPokemonDetail(request: PokemonDetailRequest) -> Observable<PokemonDetailModel?> {
        let url = APIUrl.getPokemonDetail(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<PokemonDetailModel?> in
            do {
                let responseModel = try JSONDecoder().decode(PokemonDetailModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
}
