//
//  RegisterViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 6.11.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        registerView = RegisterView(frame: self.view.frame)
        view.addSubview(registerView)
        view.backgroundColor = UIColor.white
        configureButton()
        setNavigationBar()
        registerView.emailTextField.delegate = self
        registerView.usernameTextField.delegate = self
        registerView.passwordTextField.delegate = self
    }
    
    private func configureButton() {
        registerView.backSignInButton.addTarget(self, action: #selector(didTapBackSignInButton), for: .touchUpInside)
        registerView.signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapBackSignInButton() {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 1.0) { [weak self] in
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    @objc private func didTapSignUpButton() {
        let registerRequest = RegisterUserRequest(
            email: registerView.emailTextField.text ?? "",
            password: registerView.passwordTextField.text ?? "",
            username: registerView.usernameTextField.text ?? "")
        
        if !Validator.isValidUsername(for: registerRequest.username ?? "") {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        if !Validator.isValidEmail(for: registerRequest.email ?? "") {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        if !Validator.isPasswordValid(for: registerRequest.password ?? "") {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerRequest) { [weak self]
            wasRegistered, error  in
            guard let self = self else {return}
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self , with: error)
                return
            }
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }else {
                    AlertManager.showRegistrationErrorAlert(on: self)
                }
            }
           
        }
        
        print(registerRequest)
    }
    
    private func setNavigationBar() {
        self.navigationItem.hidesBackButton = true
        
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == registerView.emailTextField {
            // Eğer emailTextField ise, sadece ilk harfi küçük yap
            let email = registerView.emailTextField.text ?? ""
            if let range = Range(range, in: email) {
                let newText = email.replacingCharacters(in: range, with: string)
                textField.text = newText.prefix(1).lowercased() + newText.dropFirst()
                return false
            }
        } else if textField == registerView.passwordTextField {
            // Eğer passwordTextField ise, aynı işlemi uygula
            let password = registerView.passwordTextField.text ?? ""
            if let range = Range(range, in: password) {
                let newText = password.replacingCharacters(in: range, with: string)
                textField.text = newText.prefix(1).lowercased() + newText.dropFirst()
                return false
            }
        } else if textField == registerView.usernameTextField {
            // Eğer usernameTextField ise, aynı işlemi uygula
            let username = registerView.usernameTextField.text ?? ""
            if let range = Range(range, in: username) {
                let newText = username.replacingCharacters(in: range, with: string)
                textField.text = newText.prefix(1).lowercased() + newText.dropFirst()
                return false
            }
        }
        return true
    }
}


