//
//  HomePageController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class HomePageController : UIViewController {
    
    var homePageVc : HomePageView!
    
    override func loadView() {
        super.loadView()
        homePageVc = HomePageView(frame: view.frame)
        view = homePageVc
        view.backgroundColor = .white
        title = "SMARTCARDS"
    }
}
