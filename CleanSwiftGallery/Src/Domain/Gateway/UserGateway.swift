//
//  UserGateway.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxSwift
protocol UserGateway {
    func getAccount() -> Single<UserEntity>
    func updateUserInfo(_ userId: Int, _ user: UserApiEntity) -> Completable
}
