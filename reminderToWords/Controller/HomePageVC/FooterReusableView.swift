//
//  ButtonSupplementaryView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 15.10.2023.
//
import UIKit

class FooterReusableView: UICollectionReusableView {
    static let identifier = "FooterReusableViewIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Burada footer için iki adet button ekleyebilirsiniz.
        // Örneğin:
        let newCardButton = UIComponentsHelper.createCustomButton(buttonTitle: "Create New Flashcard Deck", titleColor: .white, buttonBackGroundColor: .blue)
        let importButton = UIComponentsHelper.createCustomButton(buttonTitle: "Import", titleColor: .white, buttonBackGroundColor: .blue)
        
        let stackViewButtons = UIStackView(arrangedSubviews: [newCardButton, importButton])
        stackViewButtons.axis = .horizontal
        stackViewButtons.distribution = .fillEqually
        stackViewButtons.spacing = 10
        stackViewButtons.frame = bounds
        addSubview(stackViewButtons)
        
        stackViewButtons.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 20, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 80, centerXAnchor: centerXAnchor, centerYAnchor: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
