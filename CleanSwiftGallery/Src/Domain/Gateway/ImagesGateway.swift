//
//  ImagesGateway.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import RxSwift
import RxNetworkApiClient

protocol ImagesGateway {
    func getImages(_ page: Int, _ limit: Int, _ new: Bool, _ popular: Bool, withSearchBy text: String?, _ user: String?) -> Single<PaginationEntity<ImageEntity>>
    func createImageResourceWithID(name: String,
                             dateCreate: String?,
                             description: String?,
                             new: Bool,
                             popular: Bool,
                             id: Int) -> Completable
    func getMediaObject(_ id: Int) -> Single<MediaObjectEntity>
}

