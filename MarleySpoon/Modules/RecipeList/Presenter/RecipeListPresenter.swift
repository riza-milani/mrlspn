//
//  RecipeListPresenter.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation
import RxSwift

protocol RecipeListPresenterProtocol: class {
    var router: RecipeListRouterProtocol? { get set }
    var recipes: PublishSubject<[RecipeEntity]> { get set }
    func loadRecipes()
    func showRecipeDetailById(_ id: Int)
}

class RecipeListPresenter: RecipeListPresenterProtocol {

    var router: RecipeListRouterProtocol?
    var recipes: PublishSubject<[RecipeEntity]> = PublishSubject()

    func loadRecipes() {

        recipes.onNext([
            RecipeEntity(title: "name1", image: "image1", tags: ["tag1"], chef: "chef1", description: "desc 1"),
            RecipeEntity(title: "name2", image: "image2", tags: ["tag1","tag2"], chef: "chef2", description: "desc 2"),
            RecipeEntity(title: "name3", image: "image3", tags: nil, chef: "chef3", description: "desc 3")
        ])
    }

    func showRecipeDetailById(_ id: Int) {
        router?.showRecipeDetail()
    }


}
