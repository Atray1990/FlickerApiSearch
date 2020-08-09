
//
//  collectionViewCell.swift
//  FlickerUIViewProject
//
//  Created by shashank atray on 08/08/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import UIKit


class collectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var ivPlayerImage: UIImageView!
        
    var imageLoader = ImageLoader()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivPlayerImage.layer.cornerRadius = 2
    }
    
    func setupWithPhoto(flickrPhoto: FlickrPhoto) {
        lblPlayerName.text = flickrPhoto.title
        imageLoader.obtainImageWithPath(imagePath: flickrPhoto.photoUrl) { (image) in
           
            self.ivPlayerImage.image = image
        }
        /*ivPlayerImage.DownloadImageForCollectionView(from: flickrPhoto.photoUrl) { (err) in
            
            if err != nil {
                
            }
        }*/
    }
}
