//
//  FlickerViewController.swift
//  FlickerUIViewProject
//
//  Created by shashank atray on 08/08/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import UIKit

class FlickerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
   // lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 5, width: 250, height: 25))
    @IBOutlet weak var searchBar:UISearchBar!
    
    let collectionDataSource = CollectionViewDataSource()
    var eventHandler: FlickerEventHandlerConnector!
    
    var Flickerphotos: [FlickrPhoto] = []
    var pagecount = 1
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        collectionViewSetUp(count: 2)
        
    }
    
    
    func setUpViews() {
        searchBar.placeholder = "search image"
       // let leftNavBarButton = UIBarButtonItem(customView:searchBar)
       // self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.delegate = self
        
        self.collectionView.dataSource = collectionDataSource
        self.collectionView.reloadData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "GridType", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(popBack))
        navigationItem.title = "Search Flicker"
    }
    
    // just for fun and to realign collection view as per need
    @objc func addTapped(){
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "select 2 values", style: .default , handler:{ (UIAlertAction)in
            self.collectionViewSetUp(count: 2)
        }))
        
        alert.addAction(UIAlertAction(title: "select 3 values", style: .default , handler:{ (UIAlertAction)in
            self.collectionViewSetUp(count: 3)
        }))
        
        alert.addAction(UIAlertAction(title: "select 4 values", style: .default , handler:{ (UIAlertAction)in
            self.collectionViewSetUp(count: 4)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @objc func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionViewSetUp(count: CGFloat) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        
        layout.itemSize = CGSize(width: (self.view.frame.width - 20)/count, height: (self.view.frame.width - 20)/count)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView.reloadData()
        collectionView!.collectionViewLayout = layout
        
    }
    
    func showImages(photos: Photo, searchtext: String) {
        if self.Flickerphotos.isEmpty || searchtext != self.searchText {
            self.Flickerphotos = photos.photo
        
        } else if searchtext == self.searchText {
            self.Flickerphotos = Flickerphotos + photos.photo
        }
        self.pagecount = photos.page
        self.searchText = searchtext
        self.collectionDataSource.photos = self.Flickerphotos
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension FlickerViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 2 else {
            return
        }
        eventHandler.fetchChatdata(searchText: searchText, pageCount: self.pagecount)
        
    }
}

extension FlickerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let lastItem = self.Flickerphotos.count - 1
            if indexPath.row == lastItem {
                eventHandler.fetchChatdata(searchText: searchText!, pageCount: (self.pagecount + 1))
        }
    }
}


