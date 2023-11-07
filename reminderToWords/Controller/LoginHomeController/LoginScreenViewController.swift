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
    
    @objc func loginButtonTapped() -> Bool {
        let login = LoginUserRequest(email: loginView.emailTextField.text, password: loginView.passwordTextField.text)
        var hype = true
        guard
            !login.email!.isEmpty,
            !login.password!.isEmpty else {
            print("Please fill in all fields.")
            return hype
        }
        hype = false
        DispatchQueue.main.async {
            let vc = HomePageCollectionViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Login Successful!!!")
        }
        return hype
    }
    
    @objc func registerButtonTapped() {
        DispatchQueue.main.async {
            let vc = RegisterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
