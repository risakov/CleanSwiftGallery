//
//  PasswordEntity.swift
//  CleanSwiftGallery
//
//  Created by Роман on 14.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import RxNetworkApiClient

struct PasswordEntity: JsonBodyConvertible {
    var oldPassword: String
    var newPassword: String
    
    init(oldPassword: String, newPassword: String) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
    }
}
