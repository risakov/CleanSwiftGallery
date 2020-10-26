//
//  ImageViewUtil.swift
//  CleanSwiftGallery
//
//  Created by Роман on 03.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(with provider: ImageDataProvider?) {
        if let provider = provider {
            self.prepareImageLoading()
            self.kf.setImage(with: provider)
        }
    }

    func loadImage(with source: Source?) {
        if let source = source {
            self.prepareImageLoading()
            self.kf.setImage(with: source)
        }
    }

    func loadImage(with resource: Resource?) {
        if let resource = resource {
            self.prepareImageLoading()
            self.kf.setImage(with: resource)
        }
    }

    private func prepareImageLoading() {
        self.kf.indicatorType = .activity
        self.contentMode = .scaleAspectFit
    }
}
