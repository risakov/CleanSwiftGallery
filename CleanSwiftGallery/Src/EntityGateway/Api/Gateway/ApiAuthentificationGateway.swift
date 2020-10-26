//
//  ApiAuthentificationGateway.swift
//  CleanSwiftGallery
//
//  Created by Роман on 06.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import RxSwift
import RxNetworkApiClient

class ApiAuthenticationGateway: ApiBaseGateway, AuthenticationGateway {

    func auth(_ username: String, _ password: String) -> Single<TokenEntity> {
        return apiClient.execute(request: ExtendedApiRequest.loginRequest(username, password))
    }

    func refreshToken(_ refreshToken: String) -> Single<TokenEntity> {
        return apiClient.execute(request: ExtendedApiRequest.tokenRefreshRequest(refreshToken))
    }
    
}
