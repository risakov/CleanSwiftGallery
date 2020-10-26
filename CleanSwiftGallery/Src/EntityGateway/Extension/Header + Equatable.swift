//
//  Header + Equatable.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxNetworkApiClient

extension Header: Equatable {

    public static func ==(lhs: Header, rhs: Header) -> Bool {
        return lhs.key == rhs.key &&
               lhs.value == rhs.value
    }
}
