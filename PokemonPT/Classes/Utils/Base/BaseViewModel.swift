//
//  BaseViewModel.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import RxSwift
import RxCocoa

class BaseViewModel {
    var disposeBag = DisposeBag()
    var state = BehaviorRelay<LoadingState>(value: .notLoad)
    var errorModelObservable = BehaviorRelay<ResponseErrorModel?>(value: nil)
    var error: Error?
    
    var errorModel: ResponseErrorModel? {
        get { return errorModelObservable.value }
        set { errorModelObservable.accept(newValue) }
    }

    func handleNetworkError(_ error: Error) {
        if let errorResponseModel = error as? ResponseErrorModel {
            self.errorModel = errorResponseModel
        }
    }
    
    func handleError(_ error: Error?) {
        self.error = error
    }
    
    deinit {
        print("Deinit \(type(of: self))")
    }
}
