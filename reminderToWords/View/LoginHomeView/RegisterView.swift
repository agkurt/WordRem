//
//  RegisterView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 6.11.2023.
//

import UIKit

class RegisterView: UIView {
    
    let signLabel = UIComponentsHelper.createCustomLabel(text: "Sign Up", size: 20, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-SemiBold")
    let signDescriptionLabel = UIComponentsHelper.createCustomLabel(text: "Create Your Account", size: 15, labelBackGroundColor: .clear, textColor: UIColor.gray, fontName: "Poppins-Light")
    let iconImageView = UIComponentsHelper.createIconImageView()
    let emailTextField = UIComponentsHelper.createTextField(placeholder: "\tEmail...", textColor: UIColor.black, backgroundColor:  UIColor.init(hex: "#E8E8E8"))
    let passwordTextField = UIComponentsHelper.createTextField(placeholder: "\tPassword...", textColor: UIColor.black, backgroundColor:  UIColor.init(hex: "#E8E8E8"))
    let usernameTextField = UIComponentsHelper.createTextField(placeholder: "\tUsername...", textColor: UIColor.black, backgroundColor:  UIColor.init(hex: "#E8E8E8"))
    let signUpButton = UIComponentsHelper.createCustomButton(buttonTitle: "Sign Up", titleColor: UIColor.white, buttonBackGroundColor: UIColor.init(hex: "#205AFF"), UIColorName: "Poppins-SemiBold")
    let backSignInButton = UIComponentsHelper.createCustomButton(buttonTitle: "Already have an account? Sign In", titleColor: UIColor.init(hex: "#205AFF"), buttonBackGroundColor: UIColor.clear, UIColorName: "Poppins-SemiBold")


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
        addSubview(backSignInButton)
        addSubview(signLabel)
        addSubview(signDescriptionLabel)
        addSubview(iconImageView)
        addSubview(passwordTextField)
        addSubview(signUpButton)
        addSubview(usernameTextField)
    }
    
    private func configureUI() {
        
        usernameTextField.anchor(top:safeAreaLayoutGuide.topAnchor, paddingTop: 180, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        emailTextField.anchor(top: usernameTextField.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signUpButton.anchor(top: passwordTextField.bottomAnchor, paddingTop: 20, bottom:nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        backSignInButton.anchor(top:signUpButton.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 300, height: 20, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        iconImageView.anchor(top:safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 90, height: 90, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signLabel.anchor(top:iconImageView.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 120, height: 25, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signDescriptionLabel.anchor(top:signLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 200, height: 20, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        
        emailTextField.layer.cornerRadius = 20
        passwordTextField.layer.cornerRadius = 20
        usernameTextField.layer.cornerRadius = 20
        passwordTextField.isSecureTextEntry = true

        
    }
}


