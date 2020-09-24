//
//  MarleySpoonRecipeListPresenterTests.swift
//  MarleySpoonTests
//
//  Created by riza milani on 7/4/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//


import XCTest
@testable import MarleySpoon
import RxSwift

class MarleySpoonRecipeListPresenterTests: XCTestCase {

    enum InteractorMode {
        case correct
        case empty
        case error
    }
    let bag = DisposeBag()
    var presenter: RecipeListPresenter?
    let recipeEntityTest = RecipeEntity(title: "title",
                                        image: "url",
                                        tags: ["tag1"],
                                        chef: "chef",
                                        description: "desc")

    class RecipeListInteractorMock: RecipeListInteractorProtocols {

        let recipeEntities: [RecipeEntity]
        let mode: InteractorMode

        init(recipeEntities: [RecipeEntity], mode: InteractorMode) {
            self.recipeEntities = recipeEntities
            self.mode = mode
        }

        func fetchRecipes() -> Single<[RecipeEntity]> {
            switch mode {
            case .correct:
                return Single.just(recipeEntities)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            case .empty:
                return fetchEmptyRecipes()
            case .error:
                return fetchErrorRecipes()
            }
        }

        func fetchEmptyRecipes() -> Single<[RecipeEntity]> {
            Single.just([])
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        }

        func fetchErrorRecipes() -> Single<[RecipeEntity]> {
            Single.error(NSError(domain: "fetchErrorRecipes", code: 1, userInfo: nil))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        }
    }


    override func setUpWithError() throws {
        presenter = RecipeListPresenter()
        continueAfterFailure = false
    }

    func testLoadRecipesCorrectExample() throws {

        presenter?.interactor = RecipeListInteractorMock(recipeEntities: [recipeEntityTest], mode: .correct)
        let expectation = self.expectation(description: "fetching")

        presenter?.loadRecipes()

        presenter?.recipes.subscribe(onNext: { [weak self] recipeEntities in
            XCTAssertEqual(recipeEntities.count, 1)
            XCTAssertEqual(recipeEntities[0], self?.recipeEntityTest)
            expectation.fulfill()
        }).disposed(by: bag)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLoadRecipesEmptyExample() throws {

        presenter?.interactor = RecipeListInteractorMock(recipeEntities: [recipeEntityTest], mode: .empty)
        let expectation = self.expectation(description: "fetching")

        presenter?.loadRecipes()

        presenter?.recipes.subscribe(onNext: { recipeEntities in
            XCTAssertEqual(recipeEntities.count, 0)
            expectation.fulfill()
        }).disposed(by: bag)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRecipesStateCorrectExample() throws {

        let expectation = self.expectation(description: "fetching")
        presenter?.interactor = RecipeListInteractorMock(recipeEntities: [recipeEntityTest], mode: .correct)
        presenter?.loadRecipes()

        presenter?.recipeListState.subscribe(onNext: { state in
            switch state {
            case .loaded:
                break
            default:
                XCTFail("Wrong state \(state)")
            }
            expectation.fulfill()
        }).disposed(by: bag)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRecipesStateEmptyExample() throws {

        let expectation = self.expectation(description: "fetching")
        presenter?.interactor = RecipeListInteractorMock(recipeEntities: [recipeEntityTest], mode: .empty)
        presenter?.loadRecipes()

        presenter?.recipeListState.subscribe(onNext: { state in
            switch state {
            case .empty:
                break
            default:
                XCTFail("Wrong state \(state)")
            }
            expectation.fulfill()
        }).disposed(by: bag)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRecipesStateErrorExample() throws {

        let expectation = self.expectation(description: "fetching")
        presenter?.interactor = RecipeListInteractorMock(recipeEntities: [recipeEntityTest], mode: .error)
        presenter?.loadRecipes()

        presenter?.recipeListState.subscribe(onNext: { state in
            switch state {
            case .error(let error):
                XCTAssertEqual(error.localizedDescription, NSError(domain: "fetchErrorRecipes", code: 1, userInfo: nil).localizedDescription)
            default:
                XCTFail("Wrong state \(state)")
            }
            expectation.fulfill()
        }).disposed(by: bag)

        waitForExpectations(timeout: 5, handler: nil)
    }
}

