//
//  ImageEntity.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

struct Image: Codable {
    var id: Int
    var name: String
}

struct ImageEntity: Codable {
    var name: String?
    var dateCreate: String
    var description: String?
    var new: Bool
    var popular: Bool
    var id: Int
    var image: Image
    
    init(name: String?,
         dateCreate: String,
         description: String?,
         id: Int, new: Bool,
         popular: Bool,
         image: Image) {
        self.name = name
        self.dateCreate = dateCreate
        self.description = description
        self.id = id
        self.new = new
        self.popular = popular
        self.image = image
    }
}
