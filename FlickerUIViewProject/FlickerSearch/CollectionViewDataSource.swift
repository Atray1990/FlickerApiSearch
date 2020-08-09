//
//  CollectionViewDataSource.swift
//  FlickerUIViewProject
//
//  Created by shashank atray on 08/08/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation
import UIKit


class CollectionViewDataSource: NSObject, UICollectionViewDataSource  {
    
    var photos: [FlickrPhoto]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photosValue = photos {
            return photosValue.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bodyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell",for: indexPath) as! collectionViewCell
        
        bodyCell.setupWithPhoto(flickrPhoto: self.photos![indexPath.row] )
        return bodyCell
    }
    
    
}
