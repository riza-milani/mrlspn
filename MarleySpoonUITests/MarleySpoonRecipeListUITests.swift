//
//  MarleySpoonUITests.swift
//  MarleySpoonUITests
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import XCTest

class MarleySpoonRecipeListUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecipeListViewController() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let recipeListViewControllerTitle = app.staticTexts.firstMatch
        XCTAssertEqual(recipeListViewControllerTitle.label, "Recipes")

        let cell0 = app.tables.cells.element(boundBy: 0)
        XCTAssertEqual(cell0.staticTexts.firstMatch.label, "White Cheddar Grilled Cheese with Cherry Preserves & Basil")

        let cell1 = app.tables.cells.element(boundBy: 1)
        XCTAssertEqual(cell1.staticTexts.firstMatch.label, "Tofu Saag Paneer with Buttery Toasted Pita")

        let cell2 = app.tables.cells.element(boundBy: 2)
        XCTAssertEqual(cell2.staticTexts.firstMatch.label, "Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing")

        let cell3 = app.tables.cells.element(boundBy: 3)
        XCTAssertEqual(cell3.staticTexts.firstMatch.label, "Crispy Chicken and Rice\twith Peas & Arugula Salad")
    }
}
