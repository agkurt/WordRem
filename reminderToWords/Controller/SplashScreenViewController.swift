//
//  ViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    var splashView : SplashScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashView = SplashScreenView(frame: view.frame)
        view = splashView
        view.backgroundColor = UIColor(hex:"#478dff")
    }

}

