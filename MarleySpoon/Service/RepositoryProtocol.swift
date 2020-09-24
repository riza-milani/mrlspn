//
//  Repository.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation
import RxSwift

protocol RepositoryProtocol {
    func fetchRecipe() -> Observable<Result<RecipeEntity, Error>>
}

class RepositoryREST: RepositoryProtocol {
    func fetchRecipe() -> Observable<Result<RecipeEntity, Error>> {
        return Observable.create { observer -> Disposable in
            return Disposables.create()
        }
    }
}
