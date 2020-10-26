//
//  NewPhotoPresenter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.
//


import UIKit
import RxSwift

protocol NewPhotoView: BaseView
{
    
}

class NewPhotoPresenter
{
    private weak var view: NewPhotoView!
    private let router: NewPhotoRouter


    init(_ view: NewPhotoView, _ router: NewPhotoRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
}

