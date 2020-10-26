//
//  JsonContentInterceptor.swift
//  CleanSwiftGallery
//
//  Created by Роман on 06.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxNetworkApiClient

class JsonContentInterceptor: Interceptor {

    func prepare<T: Codable>(request: ApiRequest<T>) {
        var headers = request.headers ?? [Header]()

        if !headers.contains(.acceptJson) {
            headers.append(.acceptJson)
            request.headers = headers
        }
    }

    func handle<T: Codable>(request: ApiRequest<T>, response: NetworkResponse) {
        // Noting to do.
    }
}

class ExtraPathInterceptor: Interceptor {
    
    func prepare<T: Codable>(request: ApiRequest<T>) {

//        #if DEBUG
        if request.path?.contains("oauth") != true && request.path?.contains("uploads") != true && request.path?.contains("/api") != true {
            request.path = Config.extraPath + (request.path ?? "")
        }
//        #endif

    }

    func handle<T: Codable>(request: ApiRequest<T>, response: NetworkResponse) {
        // Noting to do.
    }
}


