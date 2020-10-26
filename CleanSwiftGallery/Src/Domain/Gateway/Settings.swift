//
//  Settings.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

protocol Settings: class {

    var token: TokenEntity? { get set }
    var account: UserEntity? { get set }

    func clearUserData()
}
