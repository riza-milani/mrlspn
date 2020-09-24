//
//  RecipeListInteractor.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation
import RxSwift

protocol RecipeListInteractorProtocols: class {
    func fetchRecipes() -> Single<[RecipeEntity]>
}

class RecipeListInteractor: RecipeListInteractorProtocols {

    let repository: RepositoryProtocol

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    func fetchRecipes() -> Single<[RecipeEntity]> {
        return repository.fetchRecipes()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .flatMap { result -> Single<[RecipeEntity]> in
            switch result {
            case .success(let recipes):
                return Single.just(recipes)
            case .failure(let error):
                return Single.error(error)
            }
        }.take(1).asSingle()
    }
}
