//
//  RepositoryGrapQL.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation
import RxSwift
import Apollo

class Apollo {

    static let shared = Apollo()

    let graphQLClient: ApolloClient

    init() {
        let tokens = Utils.getContentfulTokens()
        guard let spaceID = tokens.spaceID,
            let accessToken = tokens.accessToken,
            let environmentID = tokens.environmentID
            else { fatalError("Please specify SpaceID, AccessToken and EnvironmentID in the project user defined settins!") }
        let urlSessionConfiguration: URLSessionConfiguration = .default
        urlSessionConfiguration.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
        let url = URL(string: "https://graphql.contentful.com/content/v1/spaces/\(spaceID)/environments/\(environmentID)")!

        let urlSessionClient = URLSessionClient(sessionConfiguration: urlSessionConfiguration)
        let networkTransport = HTTPNetworkTransport(url: url, client: urlSessionClient)
        graphQLClient = ApolloClient(networkTransport: networkTransport)
    }
}

class RepositoryGraphQL: RepositoryProtocol {

    func fetchRecipes() -> Observable<Result<[RecipeEntity], Error>> {
        return Observable.create { observer -> Disposable in
            Apollo.shared.graphQLClient.fetch(query: AllRecipesQuery()) { response in
                switch response {
                case .success(let allRecipe):
                    let allRecipe = allRecipe.data?.recipeCollection?.items.map({ recipeItem -> RecipeEntity in
                        RecipeEntity(
                            title: recipeItem?.title,
                            image: recipeItem?.photo?.url,
                            tags: recipeItem?.tagsCollection?.items.map{($0?.name ?? "")},
                            chef: recipeItem?.chef?.name,
                            description: recipeItem?.description)
                    })
                    guard let recipes = allRecipe else {
                        observer.onNext(.failure(ClientError.failed))
                        return
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
