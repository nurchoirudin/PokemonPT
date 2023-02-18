//
//  PokemonDetailAssembly.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import Swinject

class PokemonDetailAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(NetworkProtocol.self) { r in
            return NetworkProvider()
        }
        
        container.register(PokemonDetailDataSource.self) { r in
            guard let dataProvider = r.resolve(NetworkProtocol.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return PokemonDetailRepository(remoteData: dataProvider)
        }
        
        container.register(PokemonDetailViewModel.self) { r in
            guard let dataSource = r.resolve(PokemonDetailDataSource.self) else {
                fatalError("Unexpectedly found nil while unwrapping an Optional value")
            }
            return PokemonDetailViewModel(dataSource: dataSource)
        }
    }
}
