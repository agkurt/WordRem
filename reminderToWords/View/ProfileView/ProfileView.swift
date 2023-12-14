//
//  ProfileView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 14.12.2023.
//

import UIKit

class ProfileView: UIView {
    
    let logoutButton = UIComponentsHelper.createCustomButton(buttonTitle: "Logout", titleColor:UIColor.white, buttonBackGroundColor: UIColor.blue, UIColorName: "Gilroy-Bold")
    let profileLabel = UIComponentsHelper.createCustomLabel(text: "Profile", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.black, fontName: "Gilroy-Bold")
    let emailLabel = UIComponentsHelper.createCustomLabel(text: "", size: 15, labelBackGroundColor: UIColor.clear, textColor: UIColor.black, fontName: "Gilroy-Light")
    let userNameLabel = UIComponentsHelper.createCustomLabel(text: "", size: 25, labelBackGroundColor: UIColor.clear, textColor: UIColor.white, fontName: "Gilroy-Bold")
    let emailTitleLabel = UIComponentsHelper.createCustomLabel(text: "Email", size: 25, labelBackGroundColor: UIColor.clear, textColor: UIColor.orange, fontName: "Gilroy-Bold")
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        view.addSubview(userNameLabel)
        
        profileImageView.anchor(top: view.topAnchor, paddingTop: 88, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 120, height: 120,centerXAnchor: view.centerXAnchor,centerYAnchor: nil)
        userNameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: nil, paddingLeft:0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: view.centerXAnchor, centerYAnchor: nil)
        profileImageView.layer.cornerRadius = 120 / 2
        
        return view
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "photo1")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(containerView)
        addSubview(logoutButton)
        addSubview(emailLabel)
        addSubview(emailTitleLabel)
        
        containerView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 300, centerXAnchor: nil, centerYAnchor: nil)
        logoutButton.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 100, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 100, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        emailLabel.anchor(top: emailTitleLabel.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: nil, paddingLeft:0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        emailTitleLabel.anchor(top: containerView.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft:0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
    }
    
}
