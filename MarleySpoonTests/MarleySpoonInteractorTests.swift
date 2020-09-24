//
//  MarleySpoonInteractorTests.swift
//  MarleySpoonTests
//
//  Created by riza milani on 7/4/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//


import XCTest
@testable import MarleySpoon
import RxSwift

class MarleySpoonInteractorTests: XCTestCase {

    let bag = DisposeBag()

    let recipeEntityTest = RecipeEntity(title: "title",
                                        image: "url",
                                        tags: ["tag1"],
                                        chef: "chef",
                                        description: "desc")

    var interactor: RecipeListInteractor?

    class RespositoryMock: RepositoryProtocol {

        let recipeEntities: [RecipeEntity]

        init(recipeEntities: [RecipeEntity]) {
            self.recipeEntities = recipeEntities
        }

        func fetchRecipes() -> Observable<Result<[RecipeEntity], Error>> {
            return Observable.just(.success(recipeEntities))
        }
    }

    override func setUpWithError() throws {

        let repository = RespositoryMock(recipeEntities: [recipeEntityTest])
        interactor = RecipeListInteractor(repository: repository)
    }

    func testRESTFetchRecipesExample() throws {

        let expectation = self.expectation(description: "fetching")

        interactor?.fetchRecipes().subscribe(onSuccess: { [weak self] recipeEntities in
            guard let self = self else {
                XCTFail("weak init")
                expectation.fulfill()
                return
            }
            XCTAssertEqual(recipeEntities.count, 1)
            XCTAssertEqual(recipeEntities[0], self.recipeEntityTest)
            expectation.fulfill()
        }).disposed(by: bag)

        waitForExpectations(timeout: 50, handler: nil)
    }
}
