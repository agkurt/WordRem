//
//  ForgotPasswordViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 9.11.2023.
//

import UIKit

class ForgotPasswordViewController : UIViewController {
    
    var forgotPasswordView = ForgotPasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setForgotPasswordController()
        configureButton()
    }
    
    private func setForgotPasswordController() {
        forgotPasswordView = ForgotPasswordView(frame: self.view.frame)
        view.addSubview(forgotPasswordView)
        view.backgroundColor = UIColor.white
        forgotPasswordView.emailTextField.delegate = self
    }
    
    private func configureButton() {
        forgotPasswordView.signUpButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    @objc private func didTapForgotPassword() {
        let email = forgotPasswordView.emailTextField.text ?? ""
        
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


extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == forgotPasswordView.emailTextField {
            // Eğer emailTextField ise, sadece ilk harfi küçük yap
            let email = forgotPasswordView.emailTextField.text ?? ""
            if let range = Range(range, in: email) {
                let newText = email.replacingCharacters(in: range, with: string)
                textField.text = newText.prefix(1).lowercased() + newText.dropFirst()
                return false
            }
        }
        return true
    }
}
