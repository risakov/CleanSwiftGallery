//
//  EditProfilePresenter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 13.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxSwift

protocol EditProfileView: BaseView{
}

class EditProfilePresenter {
    private weak var view: EditProfileView!
    private let router: EditProfileRouter
    private var settings: Settings?
    private var userGateway: UserGateway
    private var userUseCase: UserUseCase
    private var loginUseCase: AuthUseCase
    private var passwordGateway: PasswordGateway
    private var passwordUseCase: PasswordUseCase
    private var disposeBag = DisposeBag()
    
    init(_ view: EditProfileView,
         _ router: EditProfileRouter,
         _ settings: Settings?,
         _ userGateway: UserGateway,
         _ userUseCase: UserUseCase,
         _ loginUseCase: AuthUseCase,
         _ passwordGateway: PasswordGateway,
         _ passwordUseCase: PasswordUseCase) {
        self.view = view
        self.router = router
        self.settings = settings
        self.userGateway = userGateway
        self.userUseCase = userUseCase
        self.loginUseCase = loginUseCase
        self.passwordGateway = passwordGateway
        self.passwordUseCase = passwordUseCase
    }
    
    func logOut() {
        self.view.showChoiceDialog(message: "Вы действительно хотите выйти?",
                                   positiveMessage: "Выйти",
                                   negativeMessage: "Отмена",
                                   onChoice: { [weak self] choice in
                                    if choice {
                                        guard let self = self else { return }
                                        self.loginUseCase.logout()
                                        self.router.logOut()
                                    }
        })
    }
    
    func saveNewPassword(_ oldPassword: String?, _ newPassword: String?, _ passwordRepetition: String?, completionHandler: ()) {
        guard let oldPassword = oldPassword,
            let newPassword = newPassword,
            let passwordRepetition = passwordRepetition else {
                self.view.showErrorDialog(message: "Вы заполнили не все поля")
                completionHandler
                return
        }
        guard oldPassword != "",
            newPassword != "",
            passwordRepetition != "" else {
                self.view.showErrorDialog(message: "Вы ввели пустой пароль")
                completionHandler
                return
        }
        guard newPassword == passwordRepetition else {
            self.view.showErrorDialog(message: "Пароли не совпадают")
            completionHandler
            return
        }
        let password = PasswordEntity(oldPassword: oldPassword, newPassword: newPassword)
        guard let id = self.settings?.account?.id else { return }
        self.passwordUseCase.updatePassword(id, password)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onCompleted: { [weak self] in
                    guard let self = self else { return }
                    self.router.logOut()
                    completionHandler
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self.view.showErrorDialog(message: "Текущий пароль введен неверно")
                }
        )
            .disposed(by: self.disposeBag)
        
        
    }
    func saveMainInfo(_ email: String?, _ fullName: String?, _ birthday: String?, completion: (() -> ())? = nil) {
        
        guard let user = self.settings?.account, let id = self.settings?.account?.id else { return }
        user.updateInfo(email: email, fullName: fullName, birthday: Date.convertToRawDate(currentDate: birthday))
        self.userUseCase.updateUserInfo(id, user)
            .observeOn(MainScheduler.instance)
            .subscribe(onError: { [weak self] error in
                    self?.view.showErrorDialog(message: "Что-то пошло не так :(\nПроверьте правильность введенных данных.")
            })
            .disposed(by: self.disposeBag)
    }
    
    func getSettings() -> Settings? {
        return self.settings
    }
    
    func viewDidLoad() {
    }
}
