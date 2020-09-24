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
    var interactor: RecipeListInteractorProtocols? { get set }
    var recipes: PublishSubject<[RecipeEntity]> { get set }
    var recipeListState: PublishSubject<RecipeListState> { get set }
    func loadRecipes()
    func showRecipeDetail(_ recipe: RecipeEntity)
}

enum RecipeListState {
    case loading
    case error(error: Error)
    case loaded
    case empty
}

class RecipeListPresenter: RecipeListPresenterProtocol {

    var router: RecipeListRouterProtocol?
    var interactor: RecipeListInteractorProtocols?
    var recipes: PublishSubject<[RecipeEntity]> = PublishSubject()
    var recipeListState: PublishSubject<RecipeListState> = PublishSubject()
    let bag = DisposeBag()

    func loadRecipes() {
        recipeListState.onNext(.loading)
        interactor?.fetchRecipes().subscribe(onSuccess: { [weak self] recipes in
            self?.recipeListState.onNext(recipes.isEmpty ? .empty : .loaded)
            self?.recipes.onNext(recipes)
        }, onError: { [weak self] error in
            self?.recipeListState.onNext(.error(error: error))
        }).disposed(by: bag)
    }

    func showRecipeDetail(_ recipe: RecipeEntity) {
        router?.showRecipeDetail(recipe)
    }


}
