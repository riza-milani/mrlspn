//
//  Repository.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation
import RxSwift

enum ClientError: Error {
    case failed
}

protocol RepositoryProtocol {
    func fetchRecipes() -> Observable<Result<[RecipeEntity], Error>>
}
