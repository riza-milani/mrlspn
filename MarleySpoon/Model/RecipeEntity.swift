//
//  RecipeEntity.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation

struct RecipeEntity: Decodable {
    let title: String?
    let image: String?
    let tags: [String]?
    let chef: String?
    let description: String?
}
