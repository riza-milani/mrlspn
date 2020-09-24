//
//  RepositoryREST.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation
import RxSwift
import Contentful

class ContentfulREST {

    static let shared = ContentfulREST()

    let client: Client

    init() {

        let tokens = Utils.getContentfulTokens()

        guard let spaceID = tokens.spaceID,
            let accessToken = tokens.accessToken,
            let environmentID = tokens.environmentID
            else { fatalError("Please specify SpaceID, AccessToken and EnvironmentID in the project user defined settins!") }

        client = Client(
            spaceId: spaceID,
            environmentId: environmentID,
            accessToken: accessToken,
            host:  Host.delivery,
            clientConfiguration: .default,
            sessionConfiguration:  .default,
            persistenceIntegration: nil,
            contentTypeClasses: [RecipeEntry.self])
    }
}
class RepositoryREST: RepositoryProtocol {

    func fetchRecipes() -> Observable<Result<[RecipeEntity], Error>> {
        return Observable.create { observer -> Disposable in
            let query = QueryOn<RecipeEntry>.where(contentTypeId: RecipeEntry.contentTypeId)

            ContentfulREST.shared.client.fetchArray(of: RecipeEntry.self, matching: query) { (result: Result<HomogeneousArrayResponse<RecipeEntry>, Error>) in
                switch result {
                case .success(let entries):
                    let recipes = entries.items.map { recipe -> RecipeEntity in
                        RecipeEntity(
                            title: recipe.title,
                            image: recipe.photo?.urlString,
                            tags: recipe.tags,
                            chef: recipe.chef,
                            description: recipe.description)
                    }
                    observer.onNext(.success(recipes))

                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
