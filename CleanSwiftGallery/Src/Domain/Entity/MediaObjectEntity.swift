//
//  MediaObjectEntity.swift
//  CleanSwiftGallery
//
//  Created by Роман on 06.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

struct MediaObjectEntity: Codable {
    var file: String
    var name: String
    var id: Int

    init(file: String, name: String, id: Int) {
        self.file = file
        self.name = name
        self.id = id
    }
}
