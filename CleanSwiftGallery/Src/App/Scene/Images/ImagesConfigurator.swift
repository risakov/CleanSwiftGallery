//
//  ImagesConfigurator.swift
//  CleanSwiftGallery
//
//  Created by Роман on 02.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit


class ImagesConfigurator {

    func configure(view: ImagesViewController) {
        let router = ImagesRouter(view)
        let presenter = ImagesPresenter(view, router, DI.resolve(), DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.images.imagesViewController()!
        ImagesConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)

    }

    static func getVC() -> ImagesViewController {
        let view = R.storyboard.images.imagesViewController()!
        return view
    }

}
