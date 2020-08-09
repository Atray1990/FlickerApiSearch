//
//  GetFlickerPhotos.swift
//  FlickerUIViewProject
//
//  Created by shashank atray on 08/08/20.
//  Copyright © 2019 Shashank Atray. All rights reserved.
//

import Foundation
import UIKit

public struct Photo : Decodable {
    let page: Int
    let pages: Int
    let total: String
    let photo: [FlickrPhoto]
}

public struct FlickrPhoto : Decodable  {
    let id: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
    }
    
}
