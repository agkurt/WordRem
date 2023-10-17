//
//  NewDeckVie.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 17.10.2023.
//

import UIKit

class NewDeckView : UIView {
    
    let deckNameTextField = UIComponentsHelper.createTextField( placeholder: "Enter Deck Name...")
    let descriptionTextField = UIComponentsHelper.createTextField( placeholder: "Enter Deck Description...")
    let deckLabel = UIComponentsHelper.createLabel(text: "Deck Name", size: 15, fontName: "Poppins-SemiBold")
    let deckColorLabel = UIComponentsHelper.createLabel(text: "Deck Color", size: 15, fontName: "Poppins-SemiBold")
    let descriptionLabel = UIComponentsHelper.createLabel(text: "Description", size: 15, fontName: "Poppins-SemiBold")
    let deckView = UIComponentsHelper.createView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        deckView.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        deckView.addSubview(deckLabel)
        self.addSubview(deckNameTextField)
        self.addSubview(descriptionLabel)
        self.addSubview(descriptionTextField)
        self.addSubview(deckColorLabel)
        self.addSubview(deckView)
        
        deckLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: safeAreaLayoutGuide.leftAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 200, height: 20, centerXAnchor: nil, centerYAnchor: nil)
        deckNameTextField.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        descriptionLabel.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        descriptionTextField.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        deckColorLabel.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        deckView.anchor(top: safeAreaLayoutGuide.topAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, left: self.leftAnchor, paddingLeft: 15, right: self.rightAnchor, paddingRight: 15, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        
    }
    
    
}
