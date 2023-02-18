//
//  MovieHomeViewModel.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import RxSwift
import RxCocoa

class PokemonListViewModel: BaseViewModel {
    private let dataSource: PokemonListDataSource
    private let pokemonListModel = BehaviorRelay<PokemonListModel?>(value: nil)
    private let pokemonListRequest = BehaviorRelay<PokemonListRequest?>(value: PokemonListRequest(offset: 0, limit: 40))
    private let nextPage = BehaviorRelay<Bool>(value: false)
    private let movieSearch = BehaviorRelay<Bool>(value: false)
    
    init(dataSource: PokemonListDataSource) {
        self.dataSource = dataSource
    }
    
    func getPokemonList() {
        guard let request = pokemonListRequest.value else { return }
        state.accept(.loading)
        dataSource.getPokemonList(request: request)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                if self.nextPage.value {
                    let pokemonResult = self.pokemonListModel.value?.results
                    let newPokemonResult = model?.results
                    let newModel = PokemonListModel(count: model?.count, next: model?.next, previous: model?.previous, results: (pokemonResult ?? []) + (newPokemonResult ?? []))
                    self.pokemonListModel.accept(newModel)
                } else {
                    self.pokemonListModel.accept(model)
                }
                self.state.accept(.finished)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.handleNetworkError(error)
                self.state.accept(.failed)
            })
            .disposed(by: disposeBag)
    }
    
    func getPokemonListModel() -> PokemonListModel? {
        return pokemonListModel.value
    }
    

    func loadMore(status: Bool) {
        nextPage.accept(status)
        if nextPage.value {
            guard let offset = pokemonListRequest.value?.offset else { return }
            pokemonListRequest.accept(PokemonListRequest(offset: offset + 40))
            getPokemonList()
        }
    }

    func isLoadmore() -> Bool {
        return nextPage.value
    }
}
