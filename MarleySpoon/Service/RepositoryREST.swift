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

final class RecipeEntry: EntryDecodable, FieldKeysQueryable {

    static let contentTypeId: String = "recipe"

    let id: String
    let localeCode: String?
    let updatedAt: Date?
    let createdAt: Date?

    let title: String?
    let description: String?
    let chef: String?
    let tags: [String]?
    var photo: Asset?

    public required init(from decoder: Decoder) throws {

        let sys = try decoder.sys()

        id = sys.id
        localeCode = sys.locale
        updatedAt = sys.updatedAt
        createdAt = sys.createdAt

        let fields = try decoder.contentfulFieldsContainer(keyedBy: RecipeEntry.FieldKeys.self)

        self.description = try fields.decodeIfPresent(String.self, forKey: .description)
        self.title = try fields.decodeIfPresent(String.self, forKey: .title)
        self.tags = try? fields.decodeIfPresent([String].self, forKey: .tags)
        self.chef = try? fields.decodeIfPresent(String.self, forKey: .chef)

        try fields.resolveLink(forKey: .photo, decoder: decoder) { [weak self] image in
            self?.photo = image as? Asset
        }
    }

    enum FieldKeys: String, CodingKey {
      case photo
      case description, title, chef, tags, calories
    }
}

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
