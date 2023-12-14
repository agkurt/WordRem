//
//  HomePageView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class HomePageView : UIView {
    let infoButton = UIComponentsHelper.createCustomButton(buttonTitle: "Info", titleColor: UIColor.darkGray, buttonBackGroundColor: .clear , UIColorName: "Poppins-SemiBold")
    let descriptionLabel = UIComponentsHelper.createCustomLabel(text: "Tap Below to create or import your first deck!", size: 14, labelBackGroundColor: .clear, textColor: .black, fontName: "Poppins-Regular")
    let newCardButton = UIComponentsHelper.createCustomButton(buttonTitle: "Create New Flashcard Deck", titleColor: .white, buttonBackGroundColor: UIColor.init(hex: "#F3B941"), UIColorName: "Poppins-SemiBold")
    let importButton = UIComponentsHelper.createCustomButton(buttonTitle: "Import", titleColor: .white, buttonBackGroundColor: UIColor.init(hex: "#F3B941"), UIColorName: "Poppins-SemiBold")
    let viewForButton = UIComponentsHelper.createView()
    var stackViewButtons = UIComponentsHelper.createStackView(axis: .horizontal, spacing: 8 , distribution: .fillProportionally)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        //setupStackView()
        //configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureUI() {
        //self.addSubview(viewForButton)
        //self.addSubview(stackViewButtons)
        stackViewButtons.anchor(top: nil, paddingTop: 0, bottom: self.bottomAnchor, paddingBottom: 20, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 370, height: 80, centerXAnchor: self.centerXAnchor, centerYAnchor: nil)
        //viewForButton.anchor(top: nil, paddingTop: 0, bottom: self.bottomAnchor, paddingBottom: 0, left: self.leftAnchor, paddingLeft: 0, right: self.rightAnchor, paddingRight: 0, width: 0, height: 100, centerXAnchor: self.centerXAnchor, centerYAnchor: nil)
    }

    
    private func setupStackView() {
        stackViewButtons.addArrangedSubview(newCardButton)
        stackViewButtons.addArrangedSubview(importButton)
    }
}
