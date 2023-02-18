//
//  PokemonDetailDataSource.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import RxSwift

protocol PokemonDetailDataSource {
    func getPokemonDetail(request: PokemonDetailRequest) -> Observable<PokemonDetailModel?>
}
