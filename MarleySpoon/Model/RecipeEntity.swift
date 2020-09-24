//
//  RecipeEntity.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation

struct RecipeEntity: Codable {
    let title: String?
    let image: String?
    let tags: [String]?
    let chef: String?
    let description: String?
}

extension RecipeEntity: Equatable {
    static func == (lhs: RecipeEntity, rhs: RecipeEntity) -> Bool {
        return lhs.title == rhs.title &&
            lhs.image == rhs.image &&
            lhs.tags == rhs.tags &&
            lhs.chef == rhs.chef &&
            lhs.description == rhs.description
    }
}
