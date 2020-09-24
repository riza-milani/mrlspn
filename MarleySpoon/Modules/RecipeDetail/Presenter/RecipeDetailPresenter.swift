//
//  RecipeDetailPresenter.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation

protocol RecipeDetailPresenterProtocol: class {
    var recipe: RecipeEntity { get set }
    func getRecipe() -> RecipeEntity
}

class RecipeDetailPresenter: RecipeDetailPresenterProtocol {

    var recipe: RecipeEntity

    init(recipe: RecipeEntity) {
        self.recipe = recipe
    }

    func getRecipe() -> RecipeEntity {
        return recipe
    }
}
