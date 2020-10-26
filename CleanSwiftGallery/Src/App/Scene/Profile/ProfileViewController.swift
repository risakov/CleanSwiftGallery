//
//  ProfileViewController.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenter!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    
    var settings: Settings?
    var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presenter == nil {
            ProfileConfigurator().configure(view: self)
        }
        
        presenter?.viewDidLoad()
        
        setupRightItem()
        setupInfo()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.beginRefreshing()

    }
    
    @objc func refreshData() {
        presenter.reloadData()
    }
    
    func setupRightItem() {
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(R.image.edit(), for: .normal)
        rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton.addTarget(self, action: #selector(ProfileViewController.openEditProfileScene), for: .touchUpInside)
        let item = UIBarButtonItem(customView: rightButton)
        self.navigationItem.setRightBarButtonItems([item], animated: true)
    }
    
    @objc func openEditProfileScene() {
        presenter.openEditProfileScene()
    }
    
    
    func setupInfo() {
        self.settings = self.presenter.getSettings()
        self.username.text = self.settings?.account?.username
        if let birthday = self.settings?.account?.birthday {
            self.dateOfBirth.text = Date.convertToStringInCurrentFormat(rawDate: birthday)
        }
        
    }
}
    

extension ProfileViewController: ProfileView {
    func endRefreshing() {
        self.refreshControl?.endRefreshing()
        navigationController?.view.setNeedsLayout()
        navigationController?.view.layoutSubviews()
    }
    
    func reloadCollection() {
        self.collectionView.reloadData()
    }
    
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.presenter.countOfImages == 0 {
            collectionView.emptyMessageWithImage()
        }
        else {
            collectionView.hideEmptyMessage()
        }
        return self.presenter.countOfImages
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == self.presenter.countOfImages - 1 {
            presenter.loadMyImages()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.cellID, for: indexPath) as! ImageCell
        self.presenter.configureCell(cell, at: indexPath.item)
        return cell
    }
}
    

extension ProfileViewController: UICollectionViewDelegate {
    
}
