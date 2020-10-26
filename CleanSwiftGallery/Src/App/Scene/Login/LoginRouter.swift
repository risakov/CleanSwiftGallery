//
//  LoginRouter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.
//


import UIKit

class LoginRouter {
    
    weak var view: UIViewController!

    init(_ view: LoginViewController) {
        self.view = view
    }
    
    func close() {
        self.view.navigationController?.popViewController(animated: true)
    }
    
    func openRootScreen() {
        TabBarConfigurator.open(navigationController: self.view.navigationController!)
    }

}
