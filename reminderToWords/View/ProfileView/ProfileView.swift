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
    let userNameLabel = UIComponentsHelper.createCustomLabel(text: "", size: 30, labelBackGroundColor: UIColor.clear, textColor: UIColor.init(hex: "#00B4D8"), fontName: "Gilroy-Bold")
    let changePasswordButton = UIComponentsHelper.createCustomButton(buttonTitle: "Change Password", titleColor: UIColor.white, buttonBackGroundColor: UIColor.init(hex: "#00B4D8"), UIColorName: "Gilroy-Bold")
    let welcomeLabel = UIComponentsHelper.createCustomLabel(text: "Welcome ", size: 30, labelBackGroundColor: UIColor.clear, textColor: UIColor.init(hex: "#00B4D8"), fontName: "Gilroy-Bold")
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(userNameLabel)


        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 120, height: 120,centerXAnchor: view.centerXAnchor,centerYAnchor: nil)
        
        welcomeLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 25, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0,centerXAnchor: view.centerXAnchor,centerYAnchor: nil)
        
        
        profileImageView.layer.cornerRadius = 120 / 2
        
        return view
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profile2")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.green.cgColor
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
      
        createSystemIcon()
        
        containerView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 300, centerXAnchor: nil, centerYAnchor: nil)
        logoutButton.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 120, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 100, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        emailLabel.anchor(top: containerView.bottomAnchor, paddingTop: 45, bottom: nil, paddingBottom: 0, left: nil, paddingLeft:0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        changePasswordButton.anchor(top: nil, paddingTop: 0, bottom: logoutButton.topAnchor, paddingBottom: 10, left: nil, paddingLeft:0, right: nil, paddingRight: 0, width: 200, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
       
        userNameLabel.textAlignment = .left
        
    }
    
    private func createSystemIcon() {
        let mailIconSize: CGFloat = 35
        let mailIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: mailIconSize, height: mailIconSize))
        
        mailIcon.contentMode = .scaleAspectFit
        mailIcon.image = UIImage(systemName: "envelope.circle.fill")
        mailIcon.tintColor = UIColor.init(hex: "#00B4D8")
        mailIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mailIcon)
        
        NSLayoutConstraint.activate([
            mailIcon.widthAnchor.constraint(equalToConstant: mailIconSize),
            mailIcon.heightAnchor.constraint(equalToConstant: mailIconSize),
            mailIcon.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor),
            mailIcon.trailingAnchor.constraint(equalTo: emailLabel.leadingAnchor, constant: -5),
          
        ])
    }

}
