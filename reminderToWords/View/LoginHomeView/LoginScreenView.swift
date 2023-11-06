//
//  LoginScreenView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 6.11.2023.
//

import UIKit

class LoginScreenView: UIView {
    
    private let emailLabel = UIComponentsHelper.createCustomLabel(text: "Email", size: 20, labelBackGroundColor: .clear, textColor: UIColor.init(hex: "#7F00FF"), fontName: "Poppins-SemiBold")
    private let passwordLabel = UIComponentsHelper.createCustomLabel(text: "Password", size: 20, labelBackGroundColor: .clear, textColor: UIColor.init(hex: "#7F00FF"), fontName: "Poppins-SemiBold")
    private let emailTextField = UIComponentsHelper.createTextField(placeholder: "\tEnter your email...", textColor: UIColor.black)
    private let passwordTextField = UIComponentsHelper.createTextField(placeholder: "\tEnter your password...", textColor: UIColor.black)
    let loginButton = UIComponentsHelper.createCustomButton(buttonTitle: "Login", titleColor: UIColor.init(hex: "#7F00FF"), buttonBackGroundColor: UIColor.white, UIColorName: "Poppins-SemiBold")
    let registerButton = UIComponentsHelper.createCustomButton(buttonTitle: "Register", titleColor: UIColor.init(hex: "#7F00FF"), buttonBackGroundColor: UIColor.white, UIColorName: "Poppins-SemiBold")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupSubview()
        configureUI()
    }
    
    private func setupSubview() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(emailLabel)
        addSubview(passwordLabel)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    private func configureUI() {
        
        emailLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 150, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        passwordLabel.anchor(top: emailTextField.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        emailTextField.anchor(top: emailLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 300, height: 45, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        passwordTextField.anchor(top: passwordLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 300, height: 45, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        loginButton.anchor(top: passwordTextField.bottomAnchor, paddingTop: 50, bottom:nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 150, height: 35, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        registerButton.anchor(top: loginButton.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 150, height: 35, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.init(hex: "#7F00FF").cgColor
        
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.init(hex: "#7F00FF").cgColor
    }
}
