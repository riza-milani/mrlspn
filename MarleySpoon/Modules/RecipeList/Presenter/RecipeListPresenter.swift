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
    func loadRecipes()
    func showRecipeDetail(_ recipe: RecipeEntity)
}

class RecipeListPresenter: RecipeListPresenterProtocol {

    var router: RecipeListRouterProtocol?
    var interactor: RecipeListInteractorProtocols?
    var recipes: PublishSubject<[RecipeEntity]> = PublishSubject()
    let bag = DisposeBag()

    func loadRecipes() {

        interactor?.fetchRecipes().subscribe(onSuccess: { [weak self] recipes in
            self?.recipes.onNext(recipes)
        }, onError: { error in

        }).disposed(by: bag)
        //RepositoryGraphQL()
//        RepositoryREST()
//            .fetchRecipes()
//            .subscribe(onNext: { [weak self] result in
//            switch (result) {
//            case .success(let recipes):
//                self?.recipes.onNext(recipes)
//            case .failure(let error):
//                break
//            }
//        }, onError: { error in
//            // TODO: Complete here!
//        }).disposed(by: bag)
    }

    func showRecipeDetail(_ recipe: RecipeEntity) {
        router?.showRecipeDetail(recipe)
    }


}
