//
//  DetailViewController.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.
//


import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var imageUserName: UILabel!
    @IBOutlet weak var imageDescription: UITextView!
    @IBOutlet weak var imageDateCreate: UILabel!
    
    
    var presenter: DetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let url: URL? = URL(string: "http://gallery.dev.webant.ru/media/\(presenter.entity.image.name)")
        self.imageView.kf.indicatorType = .activity
        self.imageView.kf.setImage(with: url)
        let viewModel = ImageViewModel(entity: presenter.entity)
        if let date = viewModel.dateCreate,
            let name = presenter.entity.name,
            let description = presenter.entity.description {
            self.imageDateCreate.text = formatter.string(from: date)
            self.imageName.text = name
            self.imageDescription.text = description
        }

    }
}

extension DetailViewController: DetailView {
    
}
