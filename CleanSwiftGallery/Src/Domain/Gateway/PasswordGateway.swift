//
//  PasswordGateway.swift
//  CleanSwiftGallery
//
//  Created by Роман on 14.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//


import RxSwift
import RxNetworkApiClient

protocol PasswordGateway {
    func updatePassword(_ userId: Int, _ password: PasswordEntity) -> Completable
}
