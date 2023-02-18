//
//  PokemonListRepository.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import RxSwift

class PokemonListRepository: PokemonListDataSource {
    private let remoteData: NetworkProtocol
    
    init(remoteData: NetworkProtocol) {
        self.remoteData = remoteData
    }
    func getPokemonList(request: PokemonListRequest) -> Observable<PokemonListModel?> {
        let url = APIUrl.getPokemonList(request: request).urlString()
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return remoteData.get(url: urlString).flatMap { data -> Observable<PokemonListModel?> in
            do {
                let responseModel = try JSONDecoder().decode(PokemonListModel.self, from: data)
                return Observable.just(responseModel)
            } catch {
                return Observable.error(error)
            }
        }
    }
}
