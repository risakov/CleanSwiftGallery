//
//  UserDefaultsKey.swift
//  CleanSwiftGallery
//
//  Created by Роман on 06.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String, CaseIterable {

    case token,
         account,
         previuosAccount,
         uncompletedScripts,
         loadingBundles,
         deviceId,
        fbEndpoint
}
