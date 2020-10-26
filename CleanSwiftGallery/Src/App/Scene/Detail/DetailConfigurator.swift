//
//  DetailConfigurator.swift
//  CleanSwiftGallery
//
//  Created by Роман on 02.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit


class DetailConfigurator {

    func configure(view: DetailViewController, entity: ImageEntity) {
        let router = DetailRouter(view)
        let presenter = DetailPresenter(view, router, entity)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController, entity: ImageEntity) {
        let view = R.storyboard.detail.detailStoryboard()!
        DetailConfigurator().configure(view: view, entity: entity)
        navigationController.pushViewController(view, animated: true)

    }

    static func getVC() -> DetailViewController {
        let view = R.storyboard.detail.detailStoryboard()!
        return view
    }
    


}
