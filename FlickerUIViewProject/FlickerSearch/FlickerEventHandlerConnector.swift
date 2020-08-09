//
//  FlickerEventHandlerConnector.swift
//  FlickerUIViewProject
//
//  Created by shashank atray on 08/08/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation


open class FlickerEventHandlerConnector {
    
    let apiKey = "c9ee672014711d3be9f7b806b4c77494"
    
    weak var viewController: FlickerViewController?
    let navigator: FlickerNavigatorRouting
    let requestHandler: FlickerRequestHandler
    
    init(viewController: FlickerViewController, requestHandler: FlickerRequestHandler, navigator: FlickerNavigatorRouting) {
        self.viewController = viewController
        self.requestHandler = requestHandler
        self.navigator = navigator
    }
    
    func fetchChatdata(searchText: String, pageCount:Int) {
        //https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&tags=kitten&per_page=10&page=1
        
        let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(searchText)&format=json&nojsoncallback=1&safe_search=1&tags=kitten&per_page=10&page=\(pageCount)")!
        
        requestHandler.requestForUserDataWith(requestUrl: url) { result in
            
            if !(result.isEmpty) {
                
                self.handleFlickerApiCall(result: result as [String : AnyObject], searchtext: searchText)
            }
        }
    }
    
    func handleFlickerApiCall(result: [String: AnyObject],searchtext: String) {
        
        if let compatData = result["photos"] as? [String: AnyObject]  {
            let jsonData = try! JSONSerialization.data(withJSONObject: compatData, options: [])
           // let decoded = String(data: jsonData, encoding: .utf8)!
                       
            do {
                let pictures = try JSONDecoder().decode(Photo.self, from: jsonData)
                if let viewController = self.viewController {
                    viewController.showImages(photos: pictures, searchtext: searchtext)
                }
            } catch {
                print("can not wrap json", error)
            }
        }
        
       
    }
}
