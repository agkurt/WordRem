//
//  LoginScreenViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 6.11.2023.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    private var loginView = LoginScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.init(hex: "#CCCCFF")
        loginView = LoginScreenView(frame: self.view.frame)
        self.view.addSubview(loginView)
        configureButton()
    }
    
    private func configureButton() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        let vc = HomePageCollectionViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func registerButtonTapped() {
        print("Kayıt ol butonuna tıklandı.")
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
