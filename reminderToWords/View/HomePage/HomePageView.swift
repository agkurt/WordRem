//
//  HomePageView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class HomePageView : UIView {
    
    let infoButton = UIComponentsHelper.createCustomButton(buttonTitle: "Info", titleColor: UIColor.darkGray, buttonBackGroundColor: .clear)
    let descriptionLabel = UIComponentsHelper.createCustomLabel(text: "Tap Below to create or import your first deck!", size: 14, labelBackGroundColor: .clear, textColor: .black, fontName: "Poppins-Regular")
    let newCardButton = UIComponentsHelper.createCustomButton(buttonTitle: "Create New Flashcard Deck", titleColor: .white, buttonBackGroundColor: .blue)
    let importButton = UIComponentsHelper.createCustomButton(buttonTitle: "Import", titleColor: .white, buttonBackGroundColor: .blue)
    var stackViewButtons = UIComponentsHelper.createStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupStackView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        infoButton.anchor(top: topAnchor, paddingTop: 55, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 8, width: 50, height: 50 , centerXAnchor: nil , centerYAnchor: nil)
        descriptionLabel.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor)
        stackViewButtons.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 20, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 80, centerXAnchor: centerXAnchor, centerYAnchor: nil)
    }
    
    private func setupSubviews() {
        addSubview(infoButton)
        addSubview(descriptionLabel)
        addSubview(stackViewButtons)
    }
    
    private func setupStackView() {
        stackViewButtons.addArrangedSubview(newCardButton)
        stackViewButtons.addArrangedSubview(importButton)
    }
}
