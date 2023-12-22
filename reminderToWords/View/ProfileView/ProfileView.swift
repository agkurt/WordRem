//
//  ProfileView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 14.12.2023.
//

import UIKit

class ProfileView: UIView {
    
    let logoutButton = UIComponentsHelper.createCustomButton(buttonTitle: "Logout", titleColor:UIColor.red, buttonBackGroundColor: UIColor.clear, UIColorName: "Gilroy-Bold")
    let emailLabel = UIComponentsHelper.createCustomLabel(text: "", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.black, fontName: "Gilroy-Light")
    let userNameLabel = UIComponentsHelper.createCustomLabel(text: "", size: 30, labelBackGroundColor: UIColor.clear, textColor: UIColor.black, fontName: "Gilroy-Bold")
    let changePasswordButton = UIComponentsHelper.createCustomButton(buttonTitle: "Change Password", titleColor: UIColor.white, buttonBackGroundColor: UIColor.mainBlue, UIColorName: "Gilroy-Bold")
    let welcomeLabel = UIComponentsHelper.createCustomLabel(text: "Welcome", size: 30, labelBackGroundColor: UIColor.clear, textColor: UIColor.white, fontName: "Gilroy-Bold")
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        view.addSubview(welcomeLabel)

        profileImageView.anchor(top: view.topAnchor, paddingTop: 88, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 120, height: 120,centerXAnchor: view.centerXAnchor,centerYAnchor: nil)
        welcomeLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 25, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0,centerXAnchor: view.centerXAnchor,centerYAnchor: nil)
        
        welcomeLabel.text! += userNameLabel.text!
        
        profileImageView.layer.cornerRadius = 120 / 2
        
        return view
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profile")
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
        addSubview(changePasswordButton)
        addSubview(userNameLabel)
        createSystemIcon()
        
        containerView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 300, centerXAnchor: nil, centerYAnchor: nil)
        logoutButton.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 120, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 100, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        emailLabel.anchor(top: containerView.bottomAnchor, paddingTop: 45, bottom: nil, paddingBottom: 0, left: nil, paddingLeft:0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        changePasswordButton.anchor(top: nil, paddingTop: 0, bottom: logoutButton.topAnchor, paddingBottom: 10, left: nil, paddingLeft:0, right: nil, paddingRight: 0, width: 200, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        userNameLabel.anchor(top: emailLabel.bottomAnchor, paddingTop: 25, bottom: nil, paddingBottom: 0, left: emailLabel.leftAnchor, paddingLeft:0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        
        userNameLabel.textAlignment = .left
        
    }
    
    private func createSystemIcon() {
        let mailIconSize: CGFloat = 35
        let mailIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: mailIconSize, height: mailIconSize))
        let profileIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: mailIconSize, height: mailIconSize))
        
        profileIcon.contentMode = .scaleAspectFit
        profileIcon.image = UIImage(named: "profile")
        profileIcon.tintColor = .blue
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileIcon)
        
        mailIcon.contentMode = .scaleAspectFit
        mailIcon.image = UIImage(named: "email")
        mailIcon.tintColor = .blue
        mailIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mailIcon)
        
        NSLayoutConstraint.activate([
            mailIcon.widthAnchor.constraint(equalToConstant: mailIconSize),
            mailIcon.heightAnchor.constraint(equalToConstant: mailIconSize),
            mailIcon.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor),
            mailIcon.trailingAnchor.constraint(equalTo: emailLabel.leadingAnchor, constant: -5),
            
            profileIcon.widthAnchor.constraint(equalToConstant: mailIconSize),
            profileIcon.heightAnchor.constraint(equalToConstant: mailIconSize),
            profileIcon.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            profileIcon.trailingAnchor.constraint(equalTo: userNameLabel.leadingAnchor, constant: -5),
        ])
    }

}
