//
//  LoginPresenter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.
//


import UIKit
import RxSwift

protocol LoginView: BaseView
{
    
}

class LoginPresenter {
    private weak var view: LoginView!
    private let router: LoginRouter
    private let authentificationGateway: AuthenticationGateway
    private let authentificationUseCase: AuthUseCase
    private let settings: Settings
    private var disposeBag = DisposeBag()
    
    init(_ view: LoginView,
         _ router: LoginRouter,
         _ settings: Settings,
         _ authentificationGateway: AuthenticationGateway,
         _ authentificationUseCase: AuthUseCase) {
        self.view = view
        self.router = router
        self.settings = settings
        self.authentificationGateway = authentificationGateway
        self.authentificationUseCase = authentificationUseCase
    }
    
    func viewDidLoad() {
        if self.settings.token != nil && self.settings.account != nil {
           self.checkRoleAndOpenMainScreen()
       }
    }
    
    func checkRoleAndOpenMainScreen() {
        self.router.openRootScreen()
    }
    
    func login(_ username: String, _ password: String) {
        authentificationUseCase.logIn(username, password)
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.checkRoleAndOpenMainScreen()
                }, onError: { [weak self] (error) in
                    self?.view.showDialog(message: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
