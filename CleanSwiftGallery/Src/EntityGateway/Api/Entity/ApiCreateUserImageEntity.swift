//
//  ApiCreateUserImageEntity.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxNetworkApiClient



struct ApiCreateUserImageEntity: JsonBodyConvertible {

    let name: String
    let dateCreate: String?
    let description: String?
    let new: Bool
    let popular: Bool
    let image: String

    init(name: String,
         dateCreate: String? = nil,
         description: String? = nil,
         new: Bool,
         popular: Bool,
         image: String) {
        self.name = name
        self.dateCreate = dateCreate
        self.description = description
        self.new = new
        self.popular = popular
        self.image = image
    }
}
