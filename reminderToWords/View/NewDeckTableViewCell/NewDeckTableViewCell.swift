//
//  NewDeckTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 18.10.2023.
//

import UIKit

class NewDeckTableViewCell: UITableViewCell {
    
    let deckLabel = UIComponentsHelper.createCustomLabel(text: "Deck Name", size: 15, labelBackGroundColor: .clear, textColor: UIColor.init(hex: "#3B5BA5"), fontName: "Poppins-SemiBold")
    let deckNameTextField = UIComponentsHelper.createTextField(placeholder: "Enter Deck Name...", textColor : UIColor.black, backgroundColor: UIColor.clear)

    weak var delegate : TextFieldDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCell()
    }
    
    private func configureViewCell(){  
        setSubviews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        deckLabel.numberOfLines = 0
        deckLabel.adjustsFontSizeToFitWidth = false
        deckLabel.anchor(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        deckNameTextField.anchor(top: deckLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
      
        deckNameTextField.layer.borderWidth = 1.0
        deckNameTextField.layer.borderColor = UIColor(hex: "#3B5BA5").cgColor
        deckNameTextField.layer.cornerRadius = 10
  
    }

    func configure(with text: String, tag: Int, delegate: TextFieldDelegate) {
        deckNameTextField.text = text
        deckNameTextField.tag = tag
        deckNameTextField.delegate = delegate as? UITextFieldDelegate

    }

    private func setSubviews() {
        contentView.addSubview(deckLabel)
        contentView.addSubview(deckNameTextField)
    }
}


