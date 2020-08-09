//
//  ViewController.swift
//  FlickerUIViewProject
//
//  Created by shashank atray on 08/08/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let navigator = FlickerNavigatorRouting()

       override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
       }
       
       @IBAction func goToDevChat() {
           if let navController = self.navigationController {
                navigator.makeFlickerViewController(from: navController)
           }
       }
}


