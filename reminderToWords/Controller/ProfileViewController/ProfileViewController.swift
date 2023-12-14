//
//  ProfileViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 14.12.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var customView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        customView.button.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
    }
    
    @objc func didTapLogoutButton() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else {return}
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
}

