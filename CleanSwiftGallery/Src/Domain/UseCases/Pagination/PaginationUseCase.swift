//
//  PaginationUseCase.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import RxSwift

protocol ImagesPaginationUseCase {

    var limit: Int { get set }

    var source: PublishSubject<[ImageEntity]> { get }

    var isLoadingInProcess: Bool { get }

    func hasMorePage() -> Bool
    func loadMyImages() -> Completable
    func loadNewImages(withSearchBy text: String?) -> Completable
    func loadPopularImages(withSearchBy text: String?) -> Completable
    func reset()
}

class ImagesPaginationUseCaseImp: ImagesPaginationUseCase {
    public var limit: Int = 10

    private var countItemsLastLoadedPage: Int = 0
    public var source = PublishSubject<[ImageEntity]>()

    public var isLoadingInProcess: Bool = false

    private let gateway: ImagesGateway
    private var currentPage = 1
    private var totalItemsCount: Int?
    private var data = [ImageEntity]()
    private var requestsBag = DisposeBag()

    init(gateway: ImagesGateway) {
        self.gateway = gateway
    }

    public func hasMorePage() -> Bool {

        guard let totalItemsCount = self.totalItemsCount else {
            return true
        }

        return self.data.count < totalItemsCount
    }

    public func loadNewImages(withSearchBy text: String?) -> Completable {
        return .deferred {
            self.cancelLoading()
            self.isLoadingInProcess = true

            return self.gateway.getImages(self.currentPage, self.limit, true, false, withSearchBy: text, nil)
                        .do(onSuccess: { [weak self] (result: PaginationEntity<ImageEntity>) in
                            guard let self = self else { return }
                            self.currentPage += 1
                            self.totalItemsCount = result.totalItems
                            self.countItemsLastLoadedPage = result.data.count
                            self.data.append(contentsOf: result.data)
                            self.isLoadingInProcess = false
                            self.source.onNext(self.data)
                        }, onError: { error in
                            self.isLoadingInProcess = false
                            print("PaginationSourceUseCase: catch error =", error)
                        })
                        .asCompletable()
        }

    }
    
    public func loadMyImages() -> Completable {
        return .deferred {
            self.cancelLoading()
            self.isLoadingInProcess = true

            return self.gateway.getImages(self.currentPage, self.limit, false, false, withSearchBy: nil, nil)
                    .do(onSuccess: { [weak self] (result: PaginationEntity<ImageEntity>) in
                        guard let self = self else { return }
                        self.currentPage += 1
                        self.totalItemsCount = result.totalItems
                        self.countItemsLastLoadedPage = result.data.count
                        self.data.append(contentsOf: result.data)
                        self.isLoadingInProcess = false
                        self.source.onNext(self.data)
                    }, onError: { error in
                        self.isLoadingInProcess = false
                        print("PaginationSourceUseCase: catch error =", error)
                    })
                    .asCompletable()
        }

    }
    
    public func loadPopularImages(withSearchBy text: String?) -> Completable {
        return .deferred {
            self.cancelLoading()
            self.isLoadingInProcess = true

            return self.gateway.getImages(self.currentPage, self.limit, false, true, withSearchBy: text, nil)
                    .do(onSuccess: { [weak self] (result: PaginationEntity<ImageEntity>) in
                        guard let self = self else { return }
                        self.currentPage += 1
                        self.totalItemsCount = result.totalItems
                        self.countItemsLastLoadedPage = result.data.count
                        self.data.append(contentsOf: result.data)
                        self.isLoadingInProcess = false
                        self.source.onNext(self.data)
                    }, onError: { error in
                        self.isLoadingInProcess = false
                        print("PaginationSourceUseCase: catch error =", error)
                    })
                    .asCompletable()
        }

    }

    public func reset() {
        self.data.removeAll()
        self.totalItemsCount = nil
        self.currentPage = 1
        self.countItemsLastLoadedPage = 0
    }
    
    
    private func cancelLoading() {
        requestsBag = DisposeBag()
    }

}
