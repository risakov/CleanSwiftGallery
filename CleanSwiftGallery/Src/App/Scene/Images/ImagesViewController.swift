//
//  ImagesViewController.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.

import UIKit
import MaterialComponents.MaterialActivityIndicator

class ImagesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newPopularSegmentedControl: UISegmentedControl!
    var refreshControl: UIRefreshControl?
    let images: [UIImage] = [#imageLiteral(resourceName: "logo"), #imageLiteral(resourceName: "logo2")]
    var presenter: ImagesPresenter!
    var isNotConnected: Bool! = false
    let searchController = UISearchController()
    var isSearchActive: Bool = false


    
    @IBAction func changeSegment(_ sender: Any) {
        presenter.changeSegment(segmentRow: newPopularSegmentedControl.selectedSegmentIndex)
        collectionView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            ImagesConfigurator().configure(view: self)
        }
        presenter.viewDidLoad()
        prepareSearchController()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.beginRefreshing()
    }
    
    @objc func refreshData() {
        presenter.reloadData()
    }
    

}


extension ImagesViewController: UICollectionViewDelegate {
    
}

extension ImagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if self.presenter.countOfImages == 0 {
    //            let image = R.image.errorIcon()?.imageWith(newSize: CGSize(width: 127, height: 137))
    //            let imageView = UIImageView(image: image)
    //            imageView.contentMode = .center
    //            self.collectionView.backgroundView = imageView
                collectionView.emptyMessageWithImage()
            }
            else {
                collectionView.hideEmptyMessage()
    //            self.collectionView.backgroundView = UIView()
            }
            return self.presenter.countOfImages
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if indexPath.row == self.presenter.countOfImages - 1 {
                if newPopularSegmentedControl.selectedSegmentIndex == 0 {
                    presenter.loadNewDataOfNewImages()
                }
                else {
                    presenter.loadNewDataOfPopularImages()
                }
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.cellID, for: indexPath) as! ImageCell
            self.presenter.configureCell(cell, at: indexPath.item)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.presenter.didSelectCell(at: indexPath.item)
        }
    
}

extension ImagesViewController: ImagesView {
    
    func endRefreshing() {
        self.refreshControl?.endRefreshing()
        navigationController?.view.setNeedsLayout()
        navigationController?.view.layoutSubviews()
    }
    
    func reloadCollection() {
        self.collectionView.reloadData()
    }
    
}

extension ImagesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            self.presenter.searchProduct(by: text)
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        //
    }
    
    private func prepareSearchController() {
            
        navigationController?.view.setNeedsLayout()
        navigationController?.view.layoutSubviews()
        
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
    
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
    
        //Design
        self.searchController.searchBar.barStyle = UIBarStyle.default
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.isTranslucent = false

        let searchBarStyle = searchController.searchBar.value(forKey: "searchField") as? UITextField
        searchBarStyle?.clearButtonMode = .whileEditing
        
        searchController.searchBar.placeholder = "Search"
        
        searchController.searchBar.setImage(R.image.dictation(), for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        
        let font = UIFont.init(name: "Roboto", size: 17)
        newPopularSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font!],
                                                for: .normal)
        
        if #available(iOS 13.0, *) {
            self.searchController.automaticallyShowsCancelButton = true
        } else {
            self.searchController.searchBar.showsCancelButton = true
            self.searchController.searchBar.setShowsCancelButton(true, animated: true)
            
        }
        
        self.searchController.searchBar.setNeedsLayout()
        self.searchController.searchBar.setNeedsDisplay()
    }
}

extension ImagesViewController: UISearchBarDelegate {
    
}

extension ImagesViewController: UISearchControllerDelegate {
    
}
