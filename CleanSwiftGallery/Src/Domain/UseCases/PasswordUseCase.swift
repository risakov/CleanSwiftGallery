//
//  PasswordUseCase.swift
//  CleanSwiftGallery
//
//  Created by Роман on 14.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxSwift

protocol PasswordUseCase {
    func updatePassword(_ userId: Int, _ password: PasswordEntity) -> Completable
}

class PasswordUseCaseImp: PasswordUseCase {
    
    private var settings: Settings
    private let passwordGateway: PasswordGateway
    
    init(settings: Settings, gateway: PasswordGateway) {
        self.settings = settings
        self.passwordGateway = gateway
    }
    
    func updatePassword(_ userId: Int, _ password: PasswordEntity) -> Completable {
        return self.passwordGateway.updatePassword(userId, password)
            .observeOn(MainScheduler.instance)
            .do(onCompleted: { [weak self] in
                guard let self = self else { return }
            })
    }
}
