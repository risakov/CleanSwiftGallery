//
//  DI.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

import DITranquillity
import RxNetworkApiClient

class DI {

    private static let shared = DI()
    fileprivate(set) static var container = DIContainer()

    private init() {
        // Empty constructor
    }
    
    static func initDependencies(_ appDelegate: AppDelegate) {

        DI.container = DIContainer()
        
        ApiEndpoint.baseEndpoint = ApiEndpoint.webAntDevApi
        
        self.container.register(AuthInterceptor.init)
                .as(AuthInterceptor.self)
                .lifetime(.single)

        self.container.register {
                    AuthResponseHandler(appDelegate, $0, $1, $2)
                }
                .as(AuthResponseHandler.self)
                .lifetime(.single)
        
        // MARK: - ApiClient
        self.container.register { () -> ApiClientImp in
                    let config = URLSessionConfiguration.default
                    config.timeoutIntervalForRequest = 60 * 20
                    config.timeoutIntervalForResource = 60 * 20

                    let client = ApiClientImp(urlSessionConfiguration: config, completionHandlerQueue: .main)
                    client.responseHandlersQueue.append(ErrorResponseHandler())
                    client.responseHandlersQueue.append(JsonResponseHandler())
                    client.responseHandlersQueue.append(RuNSErrorResponseHandler())
                    client.interceptors.append(ExtendedLoggingInterceptor())
                    return client
                }
                .as(ApiClient.self)
                .injection(cycle: true) {
                    $0.responseHandlersQueue.insert($1 as AuthResponseHandler, at: 0)
                }
                .injection(cycle: true) {
                    $0.interceptors.insert($1 as AuthInterceptor, at: 0)
                }
                .lifetime(.single)

        // MARK: - Settings
        self.container.register(UserDefaultsSettingsImp.init)
                .as(UserDefaultsSettings.self)
                .lifetime(.single)
        
        self.container.register {
                    LocalSettings(userDefaults: $0)
                }
                .as(Settings.self)
                .lifetime(.single)
        
        // MARK: - Gateways
        self.container.register(ApiImagesGateway.init)
                .as(ImagesGateway.self)
                .lifetime(.single)
        
        self.container.register(ApiAuthenticationGateway.init)
                .as(AuthenticationGateway.self)
                .lifetime(.single)
        
        self.container.register(ApiUserGateway.init)
                .as(UserGateway.self)
                .lifetime(.single)
        
        self.container.register(ApiPasswordGateway.init)
            .as(PasswordGateway.self)
            .lifetime(.single)
        
        // MARK: - Use Cases
        self.container.register(ImagesPaginationUseCaseImp.init)
                .as(ImagesPaginationUseCase.self)
                .lifetime(.single)
        
        self.container.register(AuthUseCaseImp.init)
                .as(AuthUseCase.self)
                .lifetime(.single)
        
        self.container.register(UserUseCaseImp.init)
            .as(UserUseCase.self)
            .lifetime(.single)
        
        self.container.register(PasswordUseCaseImp.init)
            .as(PasswordUseCase.self)
            .lifetime(.single)

    }
    
    static func resolve<T>(name: String? = nil) -> T {
        if let name = name {
            return self.container.resolve(name: name)
        } else {
            return self.container.resolve()
        }
    }
    
}
