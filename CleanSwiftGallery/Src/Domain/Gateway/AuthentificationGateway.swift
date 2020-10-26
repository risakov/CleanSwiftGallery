//
//  AuthentificationGateway.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthenticationGateway {

    func auth(_ username: String, _ password: String) -> Single<TokenEntity>
    func refreshToken(_ refreshToken: String) -> Single<TokenEntity>
}
