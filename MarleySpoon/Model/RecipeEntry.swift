//
//  RecipeEntry.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation
import Contentful

final class RecipeEntry: EntryDecodable, FieldKeysQueryable {

    static let contentTypeId: String = "recipe"

    let id: String
    let localeCode: String?
    let updatedAt: Date?
    let createdAt: Date?

    let title: String?
    let description: String?
    var chef: String?
    var tags: [String]?
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

        try fields.resolveLinksArray(forKey: .tags, decoder: decoder) { [weak self] tagEntries in
            if let tagEntries = tagEntries as? [RecipeTagEntry] {
                self?.tags = tagEntries.map{ $0.name ?? "" }
            }
        }

        try fields.resolveLink(forKey: .chef, decoder: decoder) { [weak self] chefEntry in
            self?.chef = (chefEntry as? RecipeChefEnrty)?.name
        }

        try fields.resolveLink(forKey: .photo, decoder: decoder) { [weak self] image in
            self?.photo = image as? Asset
        }
    }

    enum FieldKeys: String, CodingKey {
      case photo
      case description, title, chef, tags, calories
    }
}
