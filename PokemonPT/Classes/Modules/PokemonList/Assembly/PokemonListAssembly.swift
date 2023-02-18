//
//  PokemonListAssembly.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import Swinject

class PokemonListAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkProtocol.self) { r in
            return NetworkProvider()
        }
        
        container.register(PokemonListDataSource.self) { r in
            guard let dataProvider = r.resolve(NetworkProtocol.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return PokemonListRepository(remoteData: dataProvider)
        }
        
        container.register(PokemonListViewModel.self) { r in
            guard let dataSource = r.resolve(PokemonListDataSource.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return PokemonListViewModel(dataSource: dataSource)
        }
    }
}
