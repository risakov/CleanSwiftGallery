//
//  PaginationEntity.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

class PaginationEntity<T: Codable>: Codable {

    var totalItems: Int
    var itemsPerPage: Int
    var countOfPages: Int
    var data: [T]

    init(totalItems: Int, itemsPerPage: Int, countOfPages: Int, data: [T]) {
        self.totalItems = totalItems
        self.itemsPerPage = itemsPerPage
        self.countOfPages = countOfPages
        self.data = data
    }
}
