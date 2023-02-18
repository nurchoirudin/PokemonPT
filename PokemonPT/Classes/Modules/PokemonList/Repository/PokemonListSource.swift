//
//  PokemonListDataSource.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import RxSwift

protocol PokemonListDataSource {
    func getPokemonList(request: PokemonListRequest) -> Observable<PokemonListModel?>
}
