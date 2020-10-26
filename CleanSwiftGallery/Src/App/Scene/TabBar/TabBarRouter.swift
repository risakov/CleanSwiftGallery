//
//  TabBarRouter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 02.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

protocol TabBarRouter {
    func openMainScreen()
    func openNewPhotoScreen()
    func openProfileScreen()
}

class TabBarRouterImp: TabBarRouter {

    private var view: TabBarController!

    init(_ view: TabBarController) {
        self.view = view
    }

    func openMainScreen() {

        let indexMainScreen = 2
        let tb = view!
        tb.selectedIndex = indexMainScreen
        let navC = tb.viewControllers?[indexMainScreen] as! UINavigationController
        navC.popToRootViewController(animated: false)
        let mainVC = ImagesConfigurator.getVC()

        navC.setViewControllers([mainVC], animated: false)
    }

    func openNewPhotoScreen() {

        let indexNewPhotoScreen = 4
        
        let tb = view!
        tb.selectedIndex = indexNewPhotoScreen
        let navC = tb.viewControllers?[indexNewPhotoScreen] as! UINavigationController
        navC.popToRootViewController(animated: false)
        let newPhotoVC = NewPhotoConfigurator.getVC()
        navC.setViewControllers([newPhotoVC], animated: false)
    }

    func openProfileScreen() {
        
        let indexProfileScreen = 0

        let tb = view!
        tb.selectedIndex = indexProfileScreen
        let navC = tb.viewControllers?[indexProfileScreen] as! UINavigationController
        navC.popToRootViewController(animated: false)
        let profileVC = ProfileConfigurator.getVC()

        navC.setViewControllers([profileVC], animated: false)
    }

}
