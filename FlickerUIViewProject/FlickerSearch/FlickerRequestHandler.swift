//
//  FlickerRequestHandler.swift
//  FlickerUIViewProject
//
//  Created by shashank atray on 08/08/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation

public protocol FlickerRequestHandlerUseCase {
    func requestForUserDataWith(requestUrl: URL, completionHandler: @escaping(_ result: [String: AnyObject]) -> ())}

extension FlickerRequestHandler {
    
    public func requestForUserDataWith(requestUrl: URL, completionHandler: @escaping(_ result: [String: AnyObject]) -> ()) {
        
        let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if (responseJSON as? [String : AnyObject]) != nil {
                               
                    completionHandler(responseJSON as! [String : AnyObject])
            }
        }
        task.resume()
    }
}

public struct FlickerRequestHandler: FlickerRequestHandlerUseCase {
    public init() {}
}
