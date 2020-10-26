//
// Created by Unicorn on 2019-05-27.
// Copyright (c) 2019 WebAnt. All rights reserved.
//

import Foundation
import RxSwift
import RxNetworkApiClient

open class AuthResponseHandler: ResponseHandler {

    private let jsonDecoder = JSONDecoder()
    private let authUseCase: AuthUseCaseImp
    private var settings: Settings
    private let apiClient: ApiClient
    private weak var delegate: AuthResponseHandlerDelegate?

    init(_ delegate: AuthResponseHandlerDelegate,
         _ authUseCase: AuthUseCaseImp,
         _ settings: Settings,
         _ apiClient: ApiClient) {
        self.delegate = delegate
        self.authUseCase = authUseCase
        self.settings = settings
        self.apiClient = apiClient
    }

    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {
        if let data = response.data,
           let responseError = try? jsonDecoder.decode(AuthErrorResponseEntity.self, from: data) {
            let error = responseError.error_description

            switch error {
                case let er where er.contains("Invalid grant_type parameter or parameter missing"):
                    observer(.error(AuthResponseHandlerError.errorApplication))
                    return true

                case let er where er.contains("The client credentials are invalid") ||
                                  er.contains("The grant type is unauthorized for this client_id"):
                    observer(.error(AuthResponseHandlerError.invalidClient))
                    return true

                case let er where er.contains("Missing parameters. \"username\" and \"password\" required"):
                    observer(.error(AuthResponseHandlerError.missingParameters))
                    return true

                case let er where er.contains("Invalid username and password combination"):
                    observer(.error(AuthResponseHandlerError.invalidCombination))
                    return true

                case let er where er.contains("Invalid refresh token"):
                    observer(.error(AuthResponseHandlerError.invalidRefreshToken))
                    delegate?.doLogout()
                    return true

                case let er where er.contains("The access token provided has expired"):
                    refreshToken(request: request, observer: observer)
                    return true

                case let er where er.contains("Refresh token has expired") ||
                                  er.contains("User account is disabled") ||
                                  er.contains("The access token provided is invalid") ||
                                  er.contains("OAuth2 authentication required"):
                    observer(.error(AuthResponseHandlerError.requiredReAuthentication))
                    delegate?.doLogout()
                    return true

                default:
                    break
            }
        }
        return false
    }

    func refreshToken<T: Codable>(request: ApiRequest<T>, observer: @escaping SingleObserver<T>) {
        guard authUseCase.tokenCondition != .refreshing else {
            return
        }
        
        guard authUseCase.tokenCondition != .none else {
            delegate?.doLogout()
            return
        }
            
        authUseCase.refreshToken()
        .subscribe(onCompleted: {
                        _ = self.apiClient.execute(request: request).subscribe(observer)
                    }, onError: { error in
                        observer(.error(error))
                    })
    }
}
