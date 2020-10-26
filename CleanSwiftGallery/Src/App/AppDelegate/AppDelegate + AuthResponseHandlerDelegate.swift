//
//  AppDelegate + AuthResponseHandlerDelegate.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

extension AppDelegate: AuthResponseHandlerDelegate {

    func doLogout() {
        self.settings?.clearUserData()
        
        guard let _ = (self.window?.rootViewController as? UINavigationController)?.viewControllers.last as? LoginViewController else {
            DispatchQueue.main.async {
                self.openLoginScreen()
            }
            return
        }
        
    }
}
