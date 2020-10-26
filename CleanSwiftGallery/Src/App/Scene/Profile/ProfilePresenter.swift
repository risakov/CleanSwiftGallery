//
//  ProfilePresenter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.
//

import UIKit
import RxSwift

protocol ProfileView: BaseView
{
    func reloadCollection()
    func endRefreshing()
}

class ProfilePresenter
{
    private weak var view: ProfileView!
    private let router: ProfileRouter
    private let gateway: ImagesGateway
    private var paginationUseCase: ImagesPaginationUseCase
    private let limitPagination: Int
    private var images = [ImageEntity]()
    private var mediaObjects = [MediaObjectEntity]()
    private var isLoading = false
    private let settings: Settings
    private var disposeBag = DisposeBag()

    var countOfImages: Int {
        return images.count
    }
    
    init(_ view: ProfileView, _ router: ProfileRouter, _ gateway: ImagesGateway, _ paginationUseCase: ImagesPaginationUseCase, _ settings: Settings) {
        self.view = view
        self.router = router
        self.gateway = gateway
        self.paginationUseCase = paginationUseCase
        self.settings = settings

        self.limitPagination = 20
        self.paginationUseCase.limit = self.limitPagination
        
        _ = paginationUseCase.source
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] (result: [ImageEntity]) in
                    guard let self = self else {
                        return
                    }
                    self.images = result
                    self.isLoading = false
                    self.view.reloadCollection()
                })
    }
    
    func openEditProfileScene() {
        self.router.openEditProfileScene()
    }
    
    func getSettings() -> Settings {
        return settings
    }
    
    func viewDidLoad() {
        
    }
    
    func reloadData() {
        self.disposeBag = DisposeBag()
        self.paginationUseCase.reset()
        self.loadMyImages()
    }
    
    func loadMyImages() {
        guard paginationUseCase.hasMorePage(), !isLoading else {
            return
        }
        self.isLoading = true
        paginationUseCase.loadMyImages()
                .observeOn(MainScheduler.instance)
                .do(onDispose: { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.view?.endRefreshing()
                    self.isLoading = false
                })
                .subscribe(onError: { [weak self] error in
                    guard let self = self else {
                        return
                    }
                    self.isLoading = false
                    self.view.showErrorDialog(message: error.localizedDescription)
                })
                .disposed(by: disposeBag)
    }
    
    func configureCell(_ cell: ImageCell, at index: Int) {
        cell.setup(self.images[index], images[index].image.name)
    }
    
    func didSelectCell(at index: Int) {
        self.router.openDetailImageScreen(entity: images[index])
    }
}
