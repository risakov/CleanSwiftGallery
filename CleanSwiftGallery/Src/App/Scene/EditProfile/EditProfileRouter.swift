//
//  EditProfileRouter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 13.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

class EditProfileRouter {
    
    weak var view: UIViewController!

    init(_ view: EditProfileViewController) {
        self.view = view
    }
    
    func logOut() {
        self.view.navigationController?.popToRootViewController(animated: false)
        UIApplication.shared.authResponseHandlerDelegate.doLogout()
    }
    
    func openDetailImageScreen(entity: ImageEntity) {
        DetailConfigurator.open(navigationController: self.view.navigationController!, entity: entity)
    }
    
}
