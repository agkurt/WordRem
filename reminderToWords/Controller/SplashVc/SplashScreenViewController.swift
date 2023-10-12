//
//  ViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    var splashView : SplashScreenView!
    
    override func loadView() {
        super.loadView()
        splashView = SplashScreenView(frame: view.frame)
        view = splashView
        view.backgroundColor = UIColor(hex:"#478dff")
        self.showOnboardingScreen()
        
    }
    
    func showOnboardingScreen() {
        let homePageVC = HomePageController()
        let navController = UINavigationController(rootViewController: homePageVC)
        
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.present(navController, animated: true, completion: nil)
        }
    }
  

}

