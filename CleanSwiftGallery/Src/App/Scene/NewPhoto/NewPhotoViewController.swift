//
//  NewPhotoViewController.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.
//

import UIKit

class NewPhotoViewController: UIViewController {
    
    var presenter: NewPhotoPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
    }
}

extension NewPhotoViewController: NewPhotoView {
    
}
