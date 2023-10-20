//
//  DeckImageTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 19.10.2023.
//

import UIKit



class DeckImageTableViewCell: UITableViewCell {
    
    let deckImageLabel = UIComponentsHelper.createCustomLabel(text: "Deck Image", size: 15, labelBackGroundColor: .clear, textColor: UIColor.systemGray, fontName: "Poppins-SemiBold")
    var selectImageButton = UIComponentsHelper.createCustomButton(buttonTitle: "Add an a Image", titleColor: .black, buttonBackGroundColor: .clear, UIColorName: "Poppins-Light")
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureDeckImageCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDeckImageCell() {
        setupViews()
        setupUI()
    }

    private func setupViews() {
        self.addSubview(deckImageLabel)
        contentView.addSubview(selectImageButton)
        selectImageButton.addTarget(self, action: #selector(didTapSelectButton), for: .touchUpInside)
    }
    
    @objc private func didTapSelectButton() {
        let deckViewController = NewDeckViewController()
        deckViewController.showImagePickerOptions()
    }
    
    private func setupUI() {
        deckImageLabel.anchor(top: self.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        selectImageButton.anchor(top: deckImageLabel.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor)
        
    }

}
