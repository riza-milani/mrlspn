//
//  MarleySpoonTests.swift
//  MarleySpoonTests
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import XCTest
@testable import MarleySpoon
import RxSwift


class MarleySpoonRepositoryTests: XCTestCase {

    var repository: RepositoryProtocol?
    let bag = DisposeBag()

    func testGraphQLFetchRecipesExample() throws {

        repository = RepositoryGraphQL()

        let expectation = self.expectation(description: "fetching")

        repository?.fetchRecipes().subscribe(onNext: { result in
            switch result {
            case .success(let recipeEntries):
                XCTAssertEqual(recipeEntries.count, 4)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }).disposed(by: bag)

        waitForExpectations(timeout: 50, handler: nil)
    }

    func testRESTFetchRecipesExample() throws {

        repository = RepositoryREST()

        let expectation = self.expectation(description: "fetching")

        repository?.fetchRecipes().subscribe(onNext: { result in
            switch result {
            case .success(let recipeEntries):
                XCTAssertEqual(recipeEntries.count, 4)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }).disposed(by: bag)

        waitForExpectations(timeout: 50, handler: nil)
    }

}
