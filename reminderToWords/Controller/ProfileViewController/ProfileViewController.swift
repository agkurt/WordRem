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
    
    var activityIndicator =  UIActivityIndicatorView()
    var loadingView = UIView()
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchEmailAndUsernameData()
        navigationController?.navigationBar.isHidden = true
        showSpinner()
        configureActivityIndicator()
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
    
    @objc func didTapChangeEmailButton() {
        print("tıklandı")
    }
    
    @objc func didTapChangePasswordButton() {
        DispatchQueue.main.async {
            let vc = PasswordController()
            vc.modalPresentationStyle = .popover
            self.present(vc, animated: true)
        }
    }
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }
    
    private func hideSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    
    private func configureActivityIndicator() {

        view.addSubview(activityIndicator)
        activityIndicator.style = .large
        view.addSubview(loadingView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
        ])
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
                hideSpinner()
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
                hideSpinner()
            }
        }
    }
}
