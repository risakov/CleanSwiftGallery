//
//  LocalSettings.swift
//  CleanSwiftGallery
//
//  Created by Роман on 06.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

class LocalSettings: Settings {

    var token: TokenEntity? {
        set(value) {
            self.userDefaults.saveData(.token, value)
        }
        get {
            return self.userDefaults.read(.token)
        }
    }

    var account: UserEntity? {
        set(value) {
            self.userDefaults.saveData(.account, value)
        }
        get {
            return self.userDefaults.read(.account)
        }
    }

    private let userDefaults: UserDefaultsSettings

    init(userDefaults: UserDefaultsSettings) {
        self.userDefaults = userDefaults
    }

    func clearUserData() {
        self.token = nil
        self.account = nil
        self.userDefaults.resetUserDefaults()
    }
}
