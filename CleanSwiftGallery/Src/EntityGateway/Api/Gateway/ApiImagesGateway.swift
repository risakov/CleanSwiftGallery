//
//  ApiImagesGateway.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class ApiImagesGateway: ApiBaseGateway, ImagesGateway {

    func getImages(_ page: Int,_ limit: Int, _ isNew: Bool, _ isPopular: Bool, withSearchBy text: String?, _ user: String?) -> Single<PaginationEntity<ImageEntity>> {
        return self.apiClient.execute(request: .getImages(page, limit, isNew, isPopular, text, user))
    }
    
    func createImageResourceWithID(name: String,
                             dateCreate: String?,
                             description: String?,
                             new: Bool,
                             popular: Bool,
                             id: Int) -> Completable {
        let request: ApiRequest<Data> = .createImageResourceWithID(name: name,
                                                             dateCreate: dateCreate,
                                                             description: description,
                                                             new: new,
                                                             popular: popular,
                                                             id: id)
        return self.apiClient.execute(request: request).asCompletable()
    }
    
    func getMediaObject(_ id: Int) -> Single<MediaObjectEntity> {
        return self.apiClient.execute(request: .getMediaObject(id))
    }
    

}
