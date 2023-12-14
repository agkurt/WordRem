//
//  SceneDelegate.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
       self.setupWindow(with: scene)
       self.checkAuthentication()
      
    }
    public func setupWindow(with scene : UIScene) {
        guard
            let windowScene = (scene as? UIWindowScene) else {return}
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            self.goToController(with: OnboardingViewController())
        }else {
            self.goToController(with: TabBarController())
        }
    }
    /// goToController
    /// - Parameter viewController: viewController description
    /// - Weak self = retaince cycle engellemek için kullanılır.
    private func goToController(with viewController :UIViewController){
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
    
}


