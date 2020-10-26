//
//  TabBarController.swift
//  CleanSwiftGallery
//
//  Created by Роман on 26.06.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var presenter: TabBarPresenter!

        override func viewDidLoad() {
            super.viewDidLoad()
            TabBarConfigurator().configure(view: self)
        }

        override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            self.generateTouchFeedback()
        }

        func generateTouchFeedback() {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }


extension TabBarController: TabBarView {

}

extension TabBarController {

    func openMainScene() {
        presenter.openMainScene()
    }

    func openNewPhotoScreen() {
        presenter.openNewPhotoScene()
    }

    func openProfileScreen() {
        presenter.openProfileScene()
    }
        
}

