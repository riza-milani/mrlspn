//
//  MarleySpoonRecipeDetailUITests.swift
//  MarleySpoonTests
//
//  Created by riza milani on 7/4/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import XCTest

class MarleySpoonRecipeDetailUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecipeDetailViewController() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let tablesQuery = app.tables
        tablesQuery.staticTexts["White Cheddar Grilled Cheese with Cherry Preserves & Basil"].tap()

        let recipeTitle = app.staticTexts.element(boundBy: 0)
        XCTAssertEqual(recipeTitle.label, "White Cheddar Grilled Cheese with Cherry Preserves & Basil")

        let recipeTag = app.staticTexts.element(boundBy: 2)
        XCTAssertEqual(recipeTag.label, "vegan")

        let recipeDescription = app.staticTexts.element(boundBy: 3)
        XCTAssertEqual(recipeDescription.label, "*Grilled Cheese 101*: Use delicious cheese and good quality bread; make crunchy on the outside and ooey gooey on the inside; add one or two ingredients for a flavor punch! In this case, cherry preserves serve as a sweet contrast to cheddar cheese, and basil adds a light, refreshing note. Use __mayonnaise__ on the outside of the bread to achieve the ultimate, crispy, golden-brown __grilled cheese__. Cook, relax, and enjoy!")

        XCTAssert(app.images.firstMatch.exists)
    }
}
