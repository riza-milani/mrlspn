//
//  RecipeListPresenter.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation

protocol RecipeListPresenterProtocol: class {
    var router: RecipeListRouterProtocol? { get set }
    func showRecipeDetailById(_ id: Int)
}

class RecipeListPresenter: RecipeListPresenterProtocol {

    var router: RecipeListRouterProtocol?

    func showRecipeDetailById(_ id: Int) {
        router?.showRecipeDetail()
    }


}
