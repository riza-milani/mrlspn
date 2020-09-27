//
//  AppRoot.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import UIKit

protocol AppRootProtocol {
    static func initRootWindow() -> UIWindow
}

class AppRoot: AppRootProtocol {

    static func initRootWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let recipeListRouter = RecipeListRouter()
        let destinationViewController = recipeListRouter.assemble()
        let navigationContoller = UINavigationController(rootViewController: destinationViewController)
        navigationContoller.modalPresentationStyle = .fullScreen
        window.rootViewController = navigationContoller
        return window
    }
}
