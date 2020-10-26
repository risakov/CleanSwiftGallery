//
//  UserEntity.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//


import Foundation
import RxNetworkApiClient

class UserEntity: JsonBodyConvertible {

    var id: Int!
    var email: String?
    var enabled: Bool?
    var phone: String?
    var fullName: String?
    var username: String?
    var birthday: String?
    var roles: [String]

    func updateInfo(email: String?, fullName: String?, birthday: String?) {
        self.email = email
        self.fullName = fullName
        self.birthday = birthday
    }
}

class UserApiEntity: JsonBodyConvertible {
    var email: String
    var fullName: String
    var birthday: String

    init(email: String, fullName: String, birthday: String) {
        self.email = email
        self.fullName = fullName
        self.birthday = birthday
    }

    init(user: UserEntity) {
        self.email = user.email ?? "ошибка в обновлении поменяйте значение"
        self.fullName = user.fullName ?? "ошибка в обновлении поменяйте значение"
        self.birthday = user.birthday ?? "ошибка в обновлении поменяйте значение"
    }

}

