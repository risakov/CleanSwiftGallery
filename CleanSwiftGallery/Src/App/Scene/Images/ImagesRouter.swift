//
//  ImagesRouter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.


import UIKit

class ImagesRouter {
    
    weak var view: UIViewController!


    init(_ view: ImagesViewController) {
        self.view = view
    }
    
    func close() {
        self.view.navigationController?.popViewController(animated: true)
    }

    func openDetailImageScreen(entity: ImageEntity) {
        DetailConfigurator.open(navigationController: self.view.navigationController!, entity: entity)
    }
}
