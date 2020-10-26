//
//  ProfileCell.swift
//  CleanSwiftGallery
//
//  Created by Роман on 13.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileCell: UICollectionViewCell {
    
    static var cellID = "profileCell"
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(_ entity: ImageEntity, _ name: String) {
        let url: URL? = URL(string: "http://gallery.dev.webant.ru/media/\(name)")
        self.imageView.kf.indicatorType = .activity
        self.imageView.kf.setImage(with: url)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.cornerRadius = 10
    }
}
