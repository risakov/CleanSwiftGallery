//
//  NewPhotoConfigurator.swift
//  CleanSwiftGallery
//
//  Created by Роман on 02.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

class NewPhotoConfigurator {

    func configure(view: NewPhotoViewController) {
        let router = NewPhotoRouter(view)
        let presenter = NewPhotoPresenter(view, router)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        var view = R.storyboard.newPhoto.newPhotoViewController()!
        NewPhotoConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }

    static func getVC() -> NewPhotoViewController {
        let view = R.storyboard.newPhoto.newPhotoViewController()!
        NewPhotoConfigurator().configure(view: view)
        return view
    }

}
