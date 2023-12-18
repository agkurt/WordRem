//
//  PasswordView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 15.12.2023.
//

import UIKit

class PasswordView : ForgotPasswordView { // UIView
    
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
        addSubview(signUpButton)
    }
    
    private func configureUI() {
        
        iconImageView.anchor(top:safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 70, height: 70, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signLabel.anchor(top:iconImageView.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 250, height: 25, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signDescriptionLabel.anchor(top:signLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 250, height: 20, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        emailTextField.anchor(top: signDescriptionLabel.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signUpButton.anchor(top: emailTextField.bottomAnchor, paddingTop: 20, bottom:nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
      
        
        emailTextField.layer.cornerRadius = 20
        
        
    }
}
