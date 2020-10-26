//
//  TabBarPresenter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 02.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxSwift

protocol TabBarPresenter {

    func openMainScene()
    func openNewPhotoScene()
    func openProfileScene()
}

protocol TabBarView {

}

class TabBarPresenterImp: TabBarPresenter {

    private let view: TabBarView
    private let router: TabBarRouter
    private var disposeBag = DisposeBag()

    init(_ view: TabBarView,
         _ router: TabBarRouter) {
        self.view = view
        self.router = router
    }

    func openMainScene() {
        router.openMainScreen()
    }

    func openNewPhotoScene() {
        router.openNewPhotoScreen()
    }

    func openProfileScene() {
        router.openProfileScreen()
    }
}
