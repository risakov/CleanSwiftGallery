//
//  ApiPasswordGateway.swift
//  CleanSwiftGallery
//
//  Created by Роман on 14.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import RxSwift
import RxNetworkApiClient

class ApiPasswordGateway: ApiBaseGateway, PasswordGateway {
    func updatePassword(_ userId: Int, _ password: PasswordEntity) -> Completable {
        let request: ApiRequest<Data> = ApiRequest.updatePassword(userId, password)
        return apiClient.execute(request: request).asCompletable()
    }
}

