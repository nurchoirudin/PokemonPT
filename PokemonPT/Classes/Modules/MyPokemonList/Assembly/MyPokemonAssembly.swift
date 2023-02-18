//
//  MyPokemonListAssembly.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import Swinject

class MyPokemonAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MyPokemonListViewModel.self) { r in
            return MyPokemonListViewModel()
        }
    }
}
