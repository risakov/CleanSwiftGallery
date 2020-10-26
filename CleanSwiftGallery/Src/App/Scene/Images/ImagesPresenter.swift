//
//  ImagesPresenter.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.

import UIKit
import RxSwift

protocol ImagesView: BaseView
{
    func reloadCollection()
    func endRefreshing() 
}

protocol CreateImagePresenter: class {
    func createImage(name: String, dateCreate: String?, description: String?, new: Bool, popular: Bool, id: Int)
}

class ImagesPresenter
{

    private weak var view: ImagesView!
    private let router: ImagesRouter
    private let gateway: ImagesGateway
    private var paginationUseCase: ImagesPaginationUseCase
    private let limitPagination: Int
    private var images = [ImageEntity]()
    private var mediaObjects = [MediaObjectEntity]()
    private var isLoading = false
    private var disposeBag = DisposeBag()
    private var currentSegmentedStateIndex: Int
    private var searchText: String?
    private var newPopularSwitcher: Int = 0
    
    var countOfImages: Int {
        return images.count
    }

    init(_ view: ImagesView,
         _ router: ImagesRouter,
         _ gateway: ImagesGateway,
         _ paginationUseCase: ImagesPaginationUseCase) {
        self.view = view
        self.router = router
        self.gateway = gateway
        self.paginationUseCase = paginationUseCase

        self.limitPagination = 10
        self.paginationUseCase.limit = self.limitPagination
        self.currentSegmentedStateIndex = 0
        
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

    func viewDidLoad() {
        self.changeSegment(segmentRow: 0)
    }
    
    func searchProduct(by text: String) {
        let newValue = text.count < 1 ? nil : text
        
        if self.searchText != newValue {
            self.searchText = newValue
            self.reloadData()
            
        }
    }
    
    func changeSegment(segmentRow: Int) {
        self.newPopularSwitcher = segmentRow
        self.disposeBag = DisposeBag()
        self.paginationUseCase.reset()
        if segmentRow == 0 {
            self.loadNewDataOfNewImages()
        }
        else {
            self.loadNewDataOfPopularImages()
        }
        self.view.reloadCollection()

    }
    
    func reloadData() {
        self.disposeBag = DisposeBag()
        self.paginationUseCase.reset()
        if self.newPopularSwitcher == 0 {
            self.loadNewDataOfNewImages()
        }
        else {
            self.loadNewDataOfPopularImages()
        }

    }
    
    func loadNewDataOfNewImages() {
        guard paginationUseCase.hasMorePage(), !isLoading else {
            return
        }
        self.isLoading = true
        paginationUseCase.loadNewImages(withSearchBy: self.searchText)
                .observeOn(MainScheduler.instance)
                .do(onDispose: { [weak self] in
                    self?.view?.endRefreshing()
                    self?.isLoading = false
                })
                .subscribe(onError: { [weak self] error in
                    self?.isLoading = false
                    self?.view.showErrorDialog(message: error.localizedDescription)
                })
                .disposed(by: disposeBag)
    }
    
    func loadNewDataOfPopularImages() {
        guard paginationUseCase.hasMorePage(), !isLoading else {
                return
            }
            self.isLoading = true
        paginationUseCase.loadPopularImages(withSearchBy: self.searchText)
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

extension ImagesPresenter: CreateImagePresenter {
    
    func createImage(name: String, dateCreate: String?, description: String?, new: Bool, popular: Bool, id: Int) {

        self.gateway.createImageResourceWithID(name: name, dateCreate: dateCreate, description: description, new: new, popular: popular, id: id)
                .observeOn(MainScheduler.instance)
                .subscribe(onCompleted: { [weak self] in
                    self?.reloadData()
                }, onError: { [weak self] error in
                    self?.view.showErrorDialog(message: error.localizedDescription)
                })
                .disposed(by: disposeBag)
    }
    
    func calculatePageForReload(for index: Int) -> Int {
        let ost = (index + 1) % self.limitPagination
        let pageIndex = (index + 1) / self.limitPagination + (ost > 0 ? 1 : 0)
        return pageIndex
    }

}
//    func reloadNewPages(from page: Int) {
//        self.paginationUseCase.reloadNewPage(from: page)
//        .observeOn(MainScheduler.instance)
//            .subscribe(onCompleted: { [weak self] in
//                self?.view.reloadCollection()
//                }, onError: { [weak self] error in
//                    self?.view.showDialog(message: "Что-то пошло не так \(error.localizedDescription)", action: { _ in
//                        self?.reloadData()
//                    })
//            })
//        .disposed(by: disposeBag)
//    }
//
//    func reloadPopularPages(from page: Int) {
//        self.paginationUseCase.reloadPopularPage(from: page)
//        .observeOn(MainScheduler.instance)
//            .subscribe(onCompleted: { [weak self] in
//                self?.view.reloadCollection()
//                }, onError: { [weak self] error in
//                    self?.view.showDialog(message: "Что-то пошло не так \(error.localizedDescription)", action: { _ in
//                        self?.reloadData()
//                    })
//            })
//        .disposed(by: disposeBag)
//    }
