//
//  Config.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxNetworkApiClient

class Config {
        static var apiEndpoint = "http://gallery.dev.webant.ru"
        static var extraPath = ""
        
        static let clientId = "32_2e5ohnjrylxcskww008wgoooo8o840cgwc404ok4kcoo08ggwk"
        static let clientSecret = "1el80cp3i728wckkss88cskk00g0ggsgc0wgc0cg0ook40s8kg"
        
        static func setState(_ type: EndpointType) {
            switch type {
            case .dev1:
                Config.apiEndpoint = "http://gallery.dev.webant.ru"
                Config.extraPath = ""
        }
    }
}



public enum EndpointType: String {
    case dev1
}
