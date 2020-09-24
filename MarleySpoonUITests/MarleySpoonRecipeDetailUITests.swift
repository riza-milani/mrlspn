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
        continueAfterFailure = true

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

        XCTAssert(app.images.firstMatch.exists)

        XCTAssert(app.staticTexts["White Cheddar Grilled Cheese with Cherry Preserves & Basil"].exists)

        XCTAssert(app.staticTexts["vegan"].exists)
    }
}
