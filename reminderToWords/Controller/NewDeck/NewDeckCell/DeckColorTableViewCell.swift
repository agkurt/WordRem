//
//  DeckColorTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 19.10.2023.
//

import UIKit

class DeckColorTableViewCell: UITableViewCell {
    
    let colors : [UIColor] = []
    let selectColorButton = UIComponentsHelper.createCustomButton(buttonTitle: "Select Color", titleColor: UIColor.white, buttonBackGroundColor: UIColor.blue, UIColorName: "Poppins-SemiBold")
    let colorsStackView = UIComponentsHelper.createStackView(axis: .horizontal, spacing: 4, distribution: .fillEqually)
    let deckColorLabel = UIComponentsHelper.createCustomLabel(text: "Deck Color", size: 15, labelBackGroundColor: .clear, textColor: .systemGray, fontName: "Poppins-SemiBold")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureDeckColorCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDeckColorCell() {
        setSubViews()
        setupUI()
        selectColorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
    }
    
    @objc func colorButtonTapped() {
        print("selected color button")
    }
    
    private func setSubViews() {
        self.addSubview(deckColorLabel)
        contentView.addSubview(selectColorButton)
    }
    
    private func configureStackView() {
    }
    
    private func setupUI() {
        deckColorLabel.anchor(top: self.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        selectColorButton.anchor(top: deckColorLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 320, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor)
        
    }
}
