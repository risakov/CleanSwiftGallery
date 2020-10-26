//
//  DetailPresenter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.
//


import UIKit

protocol DetailView: BaseView
{
    
}

class DetailPresenter
{
    private weak var view: DetailView!
    private let router: DetailRouter
    var entity: ImageEntity
    
    init(_ view: DetailView, _ router: DetailRouter, _ entity: ImageEntity) {
        self.view = view
        self.router = router
        self.entity = entity
    }
    
    func viewDidLoad() {
    }
}
