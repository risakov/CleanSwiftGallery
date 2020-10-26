//
//  ProfileConfigurator.swift
//  CleanSwiftGallery
//
//  Created by Роман on 02.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//


import UIKit

class ProfileConfigurator {

    func configure(view: ProfileViewController) {
        let router = ProfileRouter(view)
        let presenter = ProfilePresenter(view, router, DI.resolve(), DI.resolve(), DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.profile.profileViewController()!
        ProfileConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }

    static func getVC() -> ProfileViewController {
        let view = R.storyboard.profile.profileViewController()!
        ProfileConfigurator().configure(view: view)
        return view
    }

}
