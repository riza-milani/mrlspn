//
//  RecipeChefEnrty.swift
//  MarleySpoon
//
//  Created by riza milani on 7/5/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation
import Contentful

final class RecipeChefEnrty: EntryDecodable, FieldKeysQueryable {

    static let contentTypeId: String = "chef"

    let id: String
    let localeCode: String?
    let updatedAt: Date?
    let createdAt: Date?

    var name: String?

    public required init(from decoder: Decoder) throws {

        let sys = try decoder.sys()

        id = sys.id
        localeCode = sys.locale
        updatedAt = sys.updatedAt
        createdAt = sys.createdAt

        let fields = try decoder.contentfulFieldsContainer(keyedBy: RecipeChefEnrty.FieldKeys.self)

        self.name = try fields.decodeIfPresent(String.self, forKey: .name)
    }

    enum FieldKeys: String, CodingKey {
      case name
    }
}
