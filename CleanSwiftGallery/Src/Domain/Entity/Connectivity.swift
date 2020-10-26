//
//  Connectivity.swift
//  CleanSwiftGallery
//
//  Created by Роман on 08.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
