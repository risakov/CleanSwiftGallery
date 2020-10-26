//
//  ImageViewModel.swift
//  CleanSwiftGallery
//
//  Created by Роман on 08.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

struct ImageViewModel: Codable {
        var name: String?
        var dateCreate: Date?
        var description: String?
        var new: Bool
        var popular: Bool
        var id: Int
        var image: Image
        
        init(name: String?,
             dateCreate: Date?,
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
        
        init(entity: ImageEntity) {
            let formatter = DateFormatter()
            formatter.dateFormat = "-yyyy-MM-dd'T'HH:mm:ssZ"
            self.dateCreate = formatter.date(from: entity.dateCreate)
            if let name = entity.name {
                self.name = name
            }
            self.description = entity.description
            self.id = entity.id
            self.new = entity.new
            self.popular = entity.popular
            self.image = entity.image
        }

}
