//
//  TabBarConfigurator.swift
//  CleanSwiftGallery
//
//  Created by Роман on 02.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit


class TabBarConfigurator {

    func configure(view: TabBarController) {

        let router = TabBarRouterImp(view)
        let presenter = TabBarPresenterImp(view, router)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.tabBar.tabBarStoryboard()!
        TabBarConfigurator().configure(view: view)
        navigationController.setViewControllers([view], animated: true)
    }

}
