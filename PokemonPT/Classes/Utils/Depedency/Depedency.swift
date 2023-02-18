//
//  Depedency.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import Swinject

struct Dependency {
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return resolve(serviceType, name: nil)
    }
    
    func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service {
        let threadSafeContainer: Resolver = Assembler.sharedAssembler.resolver
        guard let service = threadSafeContainer.resolve(serviceType, name: name) else {
            fatalError("Unexpectedly found nil while unwrapping an Optional value")
        }
        return service
    }
}
