//
//  TokenEntity.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

class TokenEntity: Codable {

    var access_token: String
    var refresh_token: String

    init(accessToken: String, refreshToken: String) {
        self.access_token = accessToken
        self.refresh_token = refreshToken

    }
}
