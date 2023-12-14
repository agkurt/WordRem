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
        setupViewController()
    }
    
    private func setupViewController() {
        view.backgroundColor = UIColor.white
        loginView = LoginScreenView(frame: self.view.frame)
        self.view.addSubview(loginView)
        configureButton()
        setNavigationBar()
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    private func configureButton() {
        loginView.signInButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
    }
    
    @objc private func didTapForgotPasswordButton() {
        DispatchQueue.main.async {
            let vc = ForgotPasswordViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func loginButtonTapped() {
        let loginRequest = LoginUserRequest(
            email: loginView.emailTextField.text ?? "",
            password: loginView.passwordTextField.text ?? "" )
        
        if !Validator.isValidEmail(for: loginRequest.email ?? "") {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        if !Validator.isPasswordValid(for: loginRequest.password ?? "") {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.userLogin(with: loginRequest) { [weak self]
            bool, error in
            guard let self = self else {return}
            
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self , with: error)
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }else {
                AlertManager.showSignInErrorAlert(on: self)
            }
        }
        
    }
    
    @objc func registerButtonTapped() {
        DispatchQueue.main.async {
            let vc = RegisterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setNavigationBar() {
        self.navigationItem.hidesBackButton = true
        
    }
}

extension LoginScreenViewController : UITextFieldDelegate {
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == loginView.emailTextField {
            let email = loginView.emailTextField.text ?? ""
            if let range = Range(range, in: email) {
                let newText = email.replacingCharacters(in: range, with: string)
                textField.text = newText.prefix(1).lowercased() + newText.dropFirst()
                return false
            }
        } else if textField == loginView.passwordTextField {
            // Eğer passwordTextField ise, aynı işlemi uygula
            let password = loginView.passwordTextField.text ?? ""
            if let range = Range(range, in: password) {
                let newText = password.replacingCharacters(in: range, with: string)
                textField.text = newText.prefix(1).lowercased() + newText.dropFirst()
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.emailTextField {
            loginView.passwordTextField.becomeFirstResponder() // Şifre alanına geçiş yap
        } else if textField == loginView.passwordTextField {
            textField.resignFirstResponder() // Klavyeyi kapat
        }
        return true
    }
}


