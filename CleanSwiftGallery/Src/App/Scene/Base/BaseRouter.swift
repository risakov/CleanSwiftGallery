//
//  BaseRouter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

protocol BaseRouter {

    var view: UIViewController! { get }
}

extension BaseRouter {

    func dismiss(completion: (() -> Void)? = nil) {
        guard let view = self.view else { return }

        view.dismiss(animated: true, completion: completion)
    }

    func pop(completion: (() -> Void)? = nil) {
        guard let view = self.view else { return }
        view.navigationController?.popViewController(animated: true)
    }

    func popToRoot() {
        guard let view = self.view else { return }

        view.navigationController?.popToRootViewController(animated: true)
    }
}
