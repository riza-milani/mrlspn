//
//  RecipeDetailRouter.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import UIKit

protocol RecipeDetailRouterProtocol: class {
    func assemble(recipe: RecipeEntity) -> UIViewController
}

class RecipeDetailRouter: RecipeDetailRouterProtocol {
    func assemble(recipe: RecipeEntity) -> UIViewController {
        let viewController = RecipeDetailViewController()
        let presenter = RecipeDetailPresenter(recipe: recipe)
        viewController.presenter = presenter
        return viewController
    }
}
