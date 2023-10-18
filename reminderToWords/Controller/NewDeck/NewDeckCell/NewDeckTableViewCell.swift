//
//  NewDeckTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 18.10.2023.
//

import UIKit

class NewDeckTableViewCell: UITableViewCell {
    
    let deckLabel = UIComponentsHelper.createCustomLabel(text: "Deck Name", size: 15, labelBackGroundColor: .clear, textColor: UIColor.systemGray, fontName: "Poppins-SemiBold")
    let deckNameTextField = UIComponentsHelper.createTextField(placeholder: "Enter Deck Name...")
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCell()
        
    }
    
    private func configureViewCell(){
        setupUI()
        setSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        deckLabel.adjustsFontSizeToFitWidth = false
        deckLabel.numberOfLines = 0
    }
    
    private func setSubviews() {
        self.addSubview(deckLabel)
        self.addSubview(deckNameTextField)
    }
    
    
}
