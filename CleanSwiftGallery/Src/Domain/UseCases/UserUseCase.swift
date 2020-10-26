//
//  UserUseCase.swift
//  CleanSwiftGallery
//
//  Created by Роман on 14.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxSwift

protocol UserUseCase {
    func updateUserInfo(_ id: Int, _ user: UserEntity) -> Completable
}

class UserUseCaseImp: UserUseCase {
    
    private var settings: Settings
    private let userGateway: UserGateway
    
    init(settings: Settings, gateway: UserGateway) {
        self.settings = settings
        self.userGateway = gateway
    }
    
    func updateUserInfo(_ id: Int, _ user: UserEntity) -> Completable {
        let updateApiUser = UserApiEntity(user: user)
        return self.userGateway.updateUserInfo(id, updateApiUser)
            .observeOn(MainScheduler.instance)
            .do(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.settings.account = user
            })
    }
}
