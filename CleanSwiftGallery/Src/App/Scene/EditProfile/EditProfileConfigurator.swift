//
//  EditProfileConfigurator.swift
//  CleanSwiftGallery
//
//  Created by Роман on 13.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit


class EditProfileConfigurator {
    func configure(view: EditProfileViewController) {
        let router = EditProfileRouter(view)
        let presenter = EditProfilePresenter(view, router,
                                             DI.resolve(), DI.resolve(), DI.resolve(), DI.resolve(), DI.resolve(), DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.editProfile.editProfileViewController()!
        EditProfileConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }

    static func getVC() -> EditProfileViewController {
        let view = R.storyboard.editProfile.editProfileViewController()!
        EditProfileConfigurator().configure(view: view)
        return view
    }
}
