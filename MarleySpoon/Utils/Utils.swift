//
//  APIKeys.swift
//  MarleySpoon
//
//  Created by riza milani on 7/3/1399 AP.
//  Copyright © 1399 reza milani. All rights reserved.
//

import Foundation

class Utils {

    static func getContentfulTokens() -> (accessToken: String?, spaceID: String?, environmentID: String?) {
        guard let apiKeys = Bundle.main.object(forInfoDictionaryKey: "APIKeys") as? [String: String] else {
            return (nil , nil, nil)
        }
        return (apiKeys["AccessToken"], apiKeys["SpaceID"], apiKeys["EnvironmentID"])
    }
}
