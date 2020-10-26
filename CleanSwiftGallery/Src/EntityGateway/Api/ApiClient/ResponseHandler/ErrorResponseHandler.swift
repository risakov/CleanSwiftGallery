//
//  ErrorResponseHandler.swift
//  Tizer
//
//  Created by Unicorn on 03/07/2019.
//  Copyright © 2019 WebAnt. All rights reserved.
//

import Foundation
import RxSwift
import RxNetworkApiClient

open class ErrorResponseHandler: ResponseHandler {

    private let jsonDecoder = JSONDecoder()

    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {

        if let urlResponse = response.urlResponse,
           let nsHttpUrlResponse = urlResponse as? HTTPURLResponse,
           (300..<600).contains(nsHttpUrlResponse.statusCode) {
            let errorEntity = ResponseErrorEntity(response.urlResponse)
            #if DEBUG
                errorEntity.errors.append("|| \(nsHttpUrlResponse.statusCode) ||\n")

                switch nsHttpUrlResponse.statusCode {
                    case (300..<400):
                        errorEntity.errors.append("Неверный редирект.\n")
                    case (400..<500):
                        errorEntity.errors.append("Неверный запрос.\n")
                    case (500..<600):
                        errorEntity.errors.append("Ошибка сервера.\n")
                    default:
                        errorEntity.errors.append("Неизвестная ошибка.\n")
                }
            #endif

            if let data = response.data {

                if let responseAuthError = try? jsonDecoder.decode(AuthErrorResponseEntity.self, from: data) {
                    let error = responseAuthError.error_description
//                errorEntity.errors.append("\n")
                    errorEntity.errors.append(error)
                }


                if let responseError = try? jsonDecoder.decode(ErrorResponseEntity.self, from: data) {
                    let error = responseError.violations.reduce("", { (result, elem) in result +
                        (elem.localizePropertyPath) + ": " +
                        (elem.message ?? "") })
                    errorEntity.errors.append(error != "" ? error : responseError.detail)
                }
            }

            observer(.error(errorEntity))
            return true
        }
        return false
    }
}

