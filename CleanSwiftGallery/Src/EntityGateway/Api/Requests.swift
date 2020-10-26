//
//  Requests.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxNetworkApiClient

extension ApiRequest {

    static func loginRequest(_ login: String, _ password: String) -> ApiRequest {

        return request(path: "/oauth/v2/token",
                       method: .get,
                       query: ("client_id", Config.clientId),
                              ("client_secret", Config.clientSecret),
                              ("grant_type", "password"),
                              ("username", login),
                              ("password", password)
                      )
    }
    
    static func tokenRefreshRequest(_ refreshToken: String) -> ApiRequest {
        return request(path: "/oauth/v2/token",
                       method: .post,
                       formData: ["client_id": Config.clientId,
                                  "client_secret": Config.clientSecret,
                                  "grant_type": "refresh_token",
                                  "refresh_token": refreshToken]
                      )
    }
    
    static func updatePassword(_ userId: Int, _ password: PasswordEntity) -> ApiRequest {
        return request(path: "/api/users/update_password/\(userId)",
                       method: .put,
                       headers: [Header.acceptJson, Header.contentJson],
                       body: password
                      )
        
    }
    static func createMediaObject(_ base64Image: String, name: String) -> ApiRequest {
        return request(path: "/api/media_objects",
                       method: .post,
                       query: ("file", base64Image),
                              ("name", name)
                      )
    }
    
    static func getImages(_ page: Int, _ limit: Int, _ isNew: Bool, _ isPopular: Bool, _ text: String?, _ user: String?) -> ApiRequest {
        return request(path: "/api/photos",
                       method: .get,
                       query: ("page", String(page)),
                              ("limit", String(limit)),
                              ("new", String(isNew)),
                              ("popular", String(isPopular)),
                              ("name", text),
                              ("user", user)
                      )
    }
    
    static func getAccountRequest() -> ApiRequest {
        return request(path: "/api/users/current", method: .get)
    }
    
    static func updateUserInfo(_ userId: Int, _ user: UserApiEntity) -> ApiRequest {
        return request(path: "/api/users/\(userId)",
                       method: .put,
                       headers: [Header.contentJson],
                       body: user)
    }
    
    static func getMediaObject(_ id: Int) -> ApiRequest {
        return request(path: "/api/media_objects/\(id)", method: .get)
    }
    
    static func createImageResourceWithID(name: String,
                                          dateCreate: String?,
                                          description: String?,
                                          new: Bool,
                                          popular: Bool,
                                          id: Int) -> ApiRequest {
        return request(path: "/api/photos",
                       method: .post,
                       headers: [Header.contentJson],
                       body: ApiCreateUserImageEntity(name: name,
                                                      dateCreate: dateCreate,
                                                      description: description,
                                                      new: new,
                                                      popular: popular,
                                                      image: "/api/media_objects/\(String(id))"))
    }
}
