//
//  ApiUserGateway.swift
//  CleanSwiftGallery
//
//  Created by Роман on 06.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ApiUserGateway: ApiBaseGateway, UserGateway {

    func getAccount() -> Single<UserEntity> {
        return apiClient.execute(request: ApiRequest.getAccountRequest())
    }

    func updateUserInfo(_ userId: Int, _ user: UserApiEntity) -> Completable {

        let request: ApiRequest<Data> = ApiRequest.updateUserInfo(userId, user)
        return apiClient.execute(request: request).asCompletable()
    }
}
