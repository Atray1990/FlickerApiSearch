//
//  FlickerNavigatorFactoryClass.swift
//  FlickerUIViewProject
//
//  Created by shashank atray on 08/08/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation
import UIKit

public protocol FlickerNavigatable {
    func makeFlickerViewController(from navController: UINavigationController)
}

extension FlickerNavigatable {
    public func makeFlickerViewController(from navController: UINavigationController) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "FlickerViewController") as! FlickerViewController
        let requestHandler = FlickerRequestHandler()
        let navigator = FlickerNavigatorRouting()
        let eventHandler = FlickerEventHandlerConnector.init(viewController: viewController, requestHandler: requestHandler, navigator: navigator)
        viewController.eventHandler = eventHandler
        navController.pushViewController(viewController, animated: true)
    }

}

open class FlickerNavigatorRouting: FlickerNavigatable {
    public init() {
    }
}
