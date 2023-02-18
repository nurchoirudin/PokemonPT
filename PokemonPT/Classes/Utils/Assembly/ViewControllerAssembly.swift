//
//  ViewControllerAssembly.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import Swinject

class ViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(PokemonListVC.self) { _ in
            let vc = PokemonListVC()
            return vc
        }

        container.register(PokemonDetailVC.self){ (_: Resolver, pokemonName: String?) in
            let vc = PokemonDetailVC(pokemonName: pokemonName)
            return vc
        }
        
        container.register(MyPokemonVC.self) { _ in
            let vc = MyPokemonVC()
            return vc
        }
        
        container.register(PokemonSaveModalVC.self){ (_: Resolver, model: PokemonDetailModel?) in
            let vc = PokemonSaveModalVC(model: model)
            return vc
        }
    }
}
