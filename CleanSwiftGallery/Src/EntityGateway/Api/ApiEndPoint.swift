//
//  ApiEndPoint.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxNetworkApiClient

extension ApiEndpoint {

    private(set) static var webAntDevApi = ApiEndpoint(Config.apiEndpoint)
    
    static func updateEndpoint() {
        ApiEndpoint.webAntDevApi = ApiEndpoint(Config.apiEndpoint)
    }
}
