//
//  UIApplication + appRouter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 13.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

extension UIApplication {
    var authResponseHandlerDelegate: AuthResponseHandlerDelegate {
        return self.delegate as! AuthResponseHandlerDelegate
    }
    
    var appRouter: ApplicationRouter {
        return self.delegate as! ApplicationRouter
    }
}
