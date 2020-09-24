//
//  RecipeListRouter.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import UIKit

protocol RecipeListRouterProtocol: class {
    func showRecipeDetail(_ recipe: RecipeEntity)
}

class RecipeListRouter: RecipeListRouterProtocol {

    func assemble() -> UIViewController {
        let viewController = RecipeListViewController()
        let presenter = RecipeListPresenter()
        presenter.router = self
        viewController.presenter = presenter
        return viewController
    }

    func showRecipeDetail(_ recipe: RecipeEntity) {
        print("showRecipeDetail")
    }
}
