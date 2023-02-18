//
//  Injection.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import Foundation
import Swinject

struct Injection {
    
    func resolve<Service>(_ serviceType: Service.Type, name: String? = nil) -> Service {
        let threadSafeContainer: Resolver = Assembler.sharedAssembler.resolver
        guard let service = threadSafeContainer.resolve(serviceType, name: name) else {
            fatalError("Unexpectedly found nil while unwrapping an Optional value")
        }
        return service
    }
    
    func resolve<Service, Arg1>(_ serviceType: Service.Type, name: String? = nil, args arg1: Arg1) -> Service {
        let threadSafeContainer: Resolver = Assembler.sharedAssembler.resolver
        guard let service = threadSafeContainer.resolve(serviceType, name: name, argument: arg1) else {
            fatalError("Unexpectedly found nil while unwrapping an Optional value")
        }
        return service
    }
    
    func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, name: String? = nil, args arg1: Arg1, _ arg2: Arg2) -> Service {
        let threadSafeContainer: Resolver = Assembler.sharedAssembler.resolver
        guard let service = threadSafeContainer.resolve(serviceType, name: name, arguments: arg1, arg2) else {
            fatalError("Unexpectedly found nil while unwrapping an Optional value")
        }
        return service
    }
    
    func resolve<Service, Arg1, Arg2, Arg3>(_ serviceType: Service.Type, name: String? = nil, args arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service {
        let threadSafeContainer: Resolver = Assembler.sharedAssembler.resolver
        guard let service = threadSafeContainer.resolve(serviceType, name: name, arguments: arg1, arg2, arg3) else {
            fatalError("Unexpectedly found nil while unwrapping an Optional value")
        }
        return service
    }
    
    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(_ serviceType: Service.Type, name: String? = nil, args arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service {
        let threadSafeContainer: Resolver = Assembler.sharedAssembler.resolver
        guard let service = threadSafeContainer.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4) else {
            fatalError("Unexpectedly found nil while unwrapping an Optional value")
        }
        return service
    }
    
    func resolve<Service, Arg1, Arg2, Arg3, Arg4, Arg5>(_ serviceType: Service.Type, name: String? = nil, args arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Service {
        let threadSafeContainer: Resolver = Assembler.sharedAssembler.resolver
        guard let service = threadSafeContainer.resolve(serviceType, name: name, arguments: arg1, arg2, arg3, arg4, arg5) else {
            fatalError("Unexpectedly found nil while unwrapping an Optional value")
        }
        return service
    }
}
