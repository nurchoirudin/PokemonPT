//
//  Assembler.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            ViewControllerAssembly(),
            PokemonListAssembly(),
            PokemonDetailAssembly(),
            MyPokemonAssembly()
        ], container: container)
        return assembler
    }()
    
}
