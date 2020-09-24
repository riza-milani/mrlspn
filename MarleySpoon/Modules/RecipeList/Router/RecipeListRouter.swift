//
//  RecipeListRouter.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import UIKit

protocol RecipeListRouterProtocol: class {
    var viewController: UIViewController? { get set }
    func showRecipeDetail(_ recipe: RecipeEntity)
}

class RecipeListRouter: RecipeListRouterProtocol {

    var viewController: UIViewController?

    func assemble() -> UIViewController {
        let viewController = RecipeListViewController()
        let presenter = RecipeListPresenter()
        // If REST is needed uncomment bottom line and comment next line. :)
        let repository = RepositoryREST()
        //let repository = RepositoryGraphQL()
        let interactor = RecipeListInteractor(repository: repository)
        presenter.router = self
        presenter.interactor = interactor
        viewController.presenter = presenter
        self.viewController = viewController
        return viewController
    }

    func showRecipeDetail(_ recipe: RecipeEntity) {
        let router = RecipeDetailRouter()
        let detialViewController = router.assemble(recipe: recipe)
        viewController?.navigationController?.pushViewController(detialViewController, animated: true)

    }
}
