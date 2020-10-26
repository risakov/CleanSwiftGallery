//
//  AppDelegate + Routing.swift
//  CleanSwiftGallery
//
//  Created by Роман on 13.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

protocol ApplicationRouter {
    func openLaunchScreen()
    func openLoginScreen()
}

extension AppDelegate: ApplicationRouter {
    func openLaunchScreen() {
        if let window = self.window {
            UIView.transition(with: window, duration: 0, options: .transitionCrossDissolve, animations: {
                window.rootViewController = R.storyboard.launch.launchViewController()!
            })
        }
    }

    func openLoginScreen() {
        if let window = self.window, window.rootViewController == nil
            || !(window.rootViewController?.restorationIdentifier == "firstNavigationViewController") {
            UIView.transition(with: window, duration: 0, options: .transitionCrossDissolve, animations: {
                let vc = R.storyboard.login.firstNavigationViewController()!
                window.rootViewController = R.storyboard.login.firstNavigationViewController()!
            })
        }
    }
}
