//
//  MyPokemonListViewModel.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import CoreData
import RxSwift
import RxCocoa

class MyPokemonListViewModel: BaseViewModel {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonPT")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getMyPokemon() -> [MyPokemonListModel]? {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyPokemon")
        var returnValue: [MyPokemonListModel]? = []
        
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else { return returnValue }
            result.forEach { model in
                returnValue?.append(MyPokemonListModel(
                    id: model.value(forKey: "id") as? String,
                    pokemonId: model.value(forKey: "pokemonId") as? Int,
                    pokemonImageUrl: model.value(forKey: "pokemonImageURL") as? String,
                    pokemonName: model.value(forKey: "pokemonName") as? String)
                )
            }
        } catch {
            return returnValue
        }
        return returnValue
    }
    
    func deletePokemon(model: MyPokemonListModel) {
        self.state.accept(.loading)
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyPokemon")
        if let id = model.id {
            fetchRequest.predicate = NSPredicate (format: "id == %@", id)
            do {
                let result = try managedContext.fetch(fetchRequest)
                for entity in result {
                    managedContext.delete(entity as! NSManagedObject)
                }
                try managedContext.save()
                self.state.accept(.finished)
            } catch let error {
                self.state.accept(.finished)
            }
        }
    }
}
