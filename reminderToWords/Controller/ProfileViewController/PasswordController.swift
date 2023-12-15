//
//  PasswordController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 15.12.2023.
//

import UIKit

class PasswordController : UIViewController {
    
    var passwordView = PasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setForgotPasswordController()
        configureButton()
    }
    
    private func setForgotPasswordController() {
        passwordView = PasswordView(frame: self.view.frame)
        view.addSubview(passwordView)
        view.backgroundColor = UIColor.white
        passwordView.emailTextField.delegate = self
    }
    
    private func configureButton() {
        passwordView.signUpButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    @objc private func didTapForgotPassword() {
        let email = passwordView.emailTextField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else {return}
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            AlertManager.showPasswordResetSent(on: self)
        }
    }
}


extension PasswordController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordView.emailTextField {
            // Eğer emailTextField ise, sadece ilk harfi küçük yap
            let email = passwordView.emailTextField.text ?? ""
            if let range = Range(range, in: email) {
                let newText = email.replacingCharacters(in: range, with: string)
                textField.text = newText.prefix(1).lowercased() + newText.dropFirst()
                return false
            }
        }
        return true
    }
}

