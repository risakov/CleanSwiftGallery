//
// Created by Unicorn on 2019-05-27.
// Copyright (c) 2019 WebAnt. All rights reserved.
//

import Foundation

enum AuthResponseHandlerError: LocalizedError {

    case requiredReAuthentication
    case errorApplication
    case invalidClient
    case missingParameters
    case invalidCombination

    case invalidRefreshToken

    var errorDescription: String? {
        switch self {
            case .requiredReAuthentication: return "Требуется повторный вход в приложение."
            case .errorApplication: return "Ошибка приложения."
            case .invalidClient: return "Неправильно настроен api-клиент, обратитесь в техподдержку."
            case .missingParameters: return "Не указан логин или пароль."
            case .invalidCombination: return "Неправильный логин или пароль"

            case .invalidRefreshToken: return "*! Вы давно не заходили в систему, необходимо повторно авторизоваться."
        }
    }
}
