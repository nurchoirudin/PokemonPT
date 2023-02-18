//
//  PokemonDetailViewModel.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import RxSwift
import RxCocoa
import CoreData

class PokemonDetailViewModel: BaseViewModel {
    private let dataSource: PokemonDetailDataSource
    private let pokemonDetailModel = BehaviorRelay<PokemonDetailModel?>(value: nil)
    private let pokemonDetailRequest = BehaviorRelay<PokemonDetailRequest?>(value: PokemonDetailRequest(name: ""))
    private var managedObjectContext: NSManagedObjectContext?
   
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonPT")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    init(dataSource: PokemonDetailDataSource) {
        self.dataSource = dataSource
    }
    
    func getPokemonDetail(){
        guard let request = self.pokemonDetailRequest.value else { return }
        state.accept(.loading)
        dataSource.getPokemonDetail(request: request).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            self.pokemonDetailModel.accept(model)
            self.state.accept(.finished)
        }, onError: { [weak self] error in
            guard let self = self else { return }
            self.handleNetworkError(error)
            self.state.accept(.failed)
        })
        .disposed(by: disposeBag)
    }
    
    func setPokemonName(pokemonName: String?){
        pokemonDetailRequest.accept(PokemonDetailRequest(name: pokemonName))
    }
    
    func getPokemonDetailModel() -> PokemonDetailModel? {
        return pokemonDetailModel.value
    }
    
    func catchPokemon(model: MyPokemonListModel){
        let managedContext = self.persistentContainer.viewContext
        if let userEntity = NSEntityDescription.entity(forEntityName: "MyPokemon", in: managedContext){
            let insert = NSManagedObject(entity: userEntity, insertInto: managedContext)
            insert.setValue(model.id, forKey: "id")
            insert.setValue(model.pokemonId, forKey: "pokemonId")
            insert.setValue(model.pokemonImageUrl, forKey: "pokemonImageURL")
            insert.setValue(model.pokemonName, forKey: "pokemonName")
            
            do {
                try managedContext.save()
                print("SUCCESS SAVE")
            } catch let err{
                print(err)
            }
        }
    }
}
