//
//  ForgotPasswordView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 9.11.2023.
//

import UIKit

class ForgotPasswordView : UIView {
    
    
    let signLabel = UIComponentsHelper.createCustomLabel(text: "Forgot Password", size: 20, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-SemiBold")
    let signDescriptionLabel = UIComponentsHelper.createCustomLabel(text: "Reset Your Password", size: 15, labelBackGroundColor: .clear, textColor: UIColor.gray, fontName: "Poppins-Light")
    let iconImageView = UIComponentsHelper.createIconImageView()
    let emailTextField = UIComponentsHelper.createTextField(placeholder: "\tEmail", textColor: UIColor.black)
    let signUpButton = UIComponentsHelper.createCustomButton(buttonTitle: "Sign Up", titleColor: UIColor.white, buttonBackGroundColor: UIColor.init(hex: "#205AFF"), UIColorName: "Poppins-SemiBold")
  
    
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
        
        iconImageView.anchor(top:safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 90, height: 90, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signLabel.anchor(top:iconImageView.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 120, height: 25, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signDescriptionLabel.anchor(top:signLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 250, height: 20, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        emailTextField.anchor(top: signDescriptionLabel.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
        signUpButton.anchor(top: emailTextField.bottomAnchor, paddingTop: 20, bottom:nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 60, centerXAnchor: centerXAnchor, centerYAnchor:nil)
      
        
        emailTextField.layer.cornerRadius = 20
        
        
    }
}


