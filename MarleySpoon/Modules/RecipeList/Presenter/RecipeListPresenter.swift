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
    func showRecipeDetail(_ recipe: RecipeEntity)
}

class RecipeListPresenter: RecipeListPresenterProtocol {

    var router: RecipeListRouterProtocol?
    var recipes: PublishSubject<[RecipeEntity]> = PublishSubject()

    func loadRecipes() {

        recipes.onNext([
            RecipeEntity(title: "name1", image: "https://cdn5.myket.ir/icons/large/472d3ac3-d1ac-4e31-8df2-4d6e7406414b_.png", tags: ["tag1"], chef: "chef1", description: "desc 1"),
            RecipeEntity(title: "name2", image: "https://i.pinimg.com/originals/5a/0f/46/5a0f46b121771ae113666f287864c50e.png", tags: ["tag1","tag2"], chef: "chef2", description: "desc 2"),
            RecipeEntity(title: "name3", image: "https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/256x256/flower.png", tags: nil, chef: "chef3", description: "desc 3"),
            RecipeEntity(title: "name2", image: "https://i.pinimg.com/originals/5a/0f/46/5a0f46b121771ae113666f287864c50e.png", tags: ["tag1","tag2","tag2","tag2","tag2","tag2"], chef: "chef2", description: "desc 2"),
        ])
    }

    func showRecipeDetail(_ recipe: RecipeEntity) {
        router?.showRecipeDetail(recipe)
    }


}
