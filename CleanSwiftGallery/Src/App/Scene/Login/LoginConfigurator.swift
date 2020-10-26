//
//  LoginConfigurator.swift
//  CleanSwiftGallery
//
//  Created by Роман on 02.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

class LoginConfigurator {
    func configure(view: LoginViewController) {
        let router = LoginRouter(view)
        let presenter = LoginPresenter(view, router, DI.resolve(), DI.resolve(), DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.login.loginViewController()!
        LoginConfigurator().configure(view: view)
        navigationController.navigationItem.hidesBackButton = true
        navigationController.pushViewController(view, animated: true)
    }

    static func getVC() -> LoginViewController {
        let view = R.storyboard.login.loginViewController()!
        return view
    }
}
