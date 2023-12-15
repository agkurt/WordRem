//
//  ProfileViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 14.12.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchEmailAndUsernameData()
    }
    
    private func setupView() {
        view.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        profileView.logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        profileView.changePasswordButton.addTarget(self, action: #selector(didTapChangePasswordButton), for: .touchUpInside)
    }
    
    @objc func didTapChangePasswordButton() {
        DispatchQueue.main.async {
            let vc = PasswordController()
            vc.modalPresentationStyle = .fullScreen
            
        }
    }

    
    @objc func didTapLogoutButton() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else {return}
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    func fetchEmailAndUsernameData() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(currentUserUID)
        
        userRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }
            
            guard let document = document else {
                print("User document not found")
                return
            }
            
            if let email = document["email"] as? String,
               let username = document["username"] as? String {
                profileView.emailLabel.text = email
                profileView.userNameLabel.text = username
                print("User Email: \(email), Username: \(username)")
            }
        }
    }
}
