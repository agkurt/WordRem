//
//  LoginScreenView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 6.11.2023.
//

import UIKit

class LoginScreenView: UIView {
    
    let signLabel = UIComponentsHelper.createCustomLabel(text: "Sign In", size: 20, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-SemiBold")
    let signDescriptionLabel = UIComponentsHelper.createCustomLabel(text: "Sign in to your account", size: 15, labelBackGroundColor: .clear, textColor: UIColor.gray, fontName: "Poppins-Light")
    let iconImageView = UIComponentsHelper.createIconImageView()
    let emailTextField = UIComponentsHelper.createTextField(placeholder: "\tEmail...", textColor: UIColor.black)
    let passwordTextField = UIComponentsHelper.createTextField(placeholder: "\tPassword...", textColor: UIColor.black)
    let signInButton = UIComponentsHelper.createCustomButton(buttonTitle: "Sign In", titleColor: UIColor.white, buttonBackGroundColor: UIColor.init(hex: "#205AFF"), UIColorName: "Poppins-SemiBold")
    let registerButton = UIComponentsHelper.createCustomButton(buttonTitle: "New User? Create Account", titleColor: UIColor.init(hex: "#205AFF"), buttonBackGroundColor: UIColor.clear, UIColorName: "Poppins-SemiBold")
    let forgotPasswordButton = UIComponentsHelper.createCustomButton(buttonTitle: "Forgot Password?", titleColor: UIColor.init(hex: "#1180FF"), buttonBackGroundColor: UIColor.clear, UIColorName: "Poppins-SemiBold")
    

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
        addSubview(signLabel)
        addSubview(signDescriptionLabel)
        addSubview(iconImageView)
        addSubview(forgotPasswordButton)
        addSubview(passwordTextField)
        addSubview(signInButton)
        addSubview(registerButton)
    }
    
    private func configureUI() {
        
        emailTextField.anchor(top: safeAreaLayoutGuide.topAnchor, paddingTop: 180, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signInButton.anchor(top: passwordTextField.bottomAnchor, paddingTop: 20, bottom:nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        registerButton.anchor(top: signInButton.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 300, height: 35, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        forgotPasswordButton.anchor(top:registerButton.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 200, height: 35, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        iconImageView.anchor(top:safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 90, height: 90, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signLabel.anchor(top:iconImageView.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 75, height: 25, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signDescriptionLabel.anchor(top:signLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 200, height: 20, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        
        emailTextField.layer.cornerRadius = 20
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.isSecureTextEntry = true
        
    }
}
