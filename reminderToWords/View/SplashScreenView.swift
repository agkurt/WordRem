//
//  SplashScreenView.swift
//  reminderToWords // LUPA
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class SplashScreenView : UIView {
    
    let userButton = UIComponentsHelper.createCustomButton(buttonTitle: "Create Word", titleColor:.white, buttonBackGroundColor: .black)
    let userLabel = UIComponentsHelper.createCustomLabel(text: "SMARTCARDS", size: 30, labelBackGroundColor: .clear, textColor: .white , fontName: "Poppins-SemiBold")
    let userDescriptionLabel = UIComponentsHelper.createCustomLabel(text: "Study smarter, learn faster, and remember\n longer with spaced repetition", size: 17, labelBackGroundColor: .clear, textColor: .white, fontName: "Poppins-Regular")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(userButton)
        addSubview(userLabel)
        addSubview(userDescriptionLabel)
    }
    private func configureLabel() {
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userLabel.widthAnchor.constraint(equalToConstant: 250),
            userLabel.heightAnchor.constraint(equalToConstant: 25),
            userLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            userLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 150),
            
            userDescriptionLabel.widthAnchor.constraint(equalToConstant: 380),
            userDescriptionLabel.heightAnchor.constraint(equalToConstant: 100),
            userDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            userDescriptionLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 10)
            
        ])
    }
 
    
}
