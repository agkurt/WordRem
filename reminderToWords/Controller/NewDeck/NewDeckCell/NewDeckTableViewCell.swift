//
//  NewDeckTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 18.10.2023.
//

import UIKit

class NewDeckTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    let deckLabel = UIComponentsHelper.createCustomLabel(text: "Deck Name", size: 15, labelBackGroundColor: .clear, textColor: UIColor.systemGray, fontName: "Poppins-SemiBold")
    let deckNameTextField = UIComponentsHelper.createTextField(placeholder: "Enter Deck Name...")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCell()
        deckNameTextField.delegate = self
    }
    
    private func configureViewCell(){
        setSubviews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updateText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        print("Güncellenen metin: \(updateText)")
        return true
    }
    
    func getDeckText() -> String {
        return deckNameTextField.text ?? ""
    }
    
    func configure(with text: String, tag: Int, delegate: UITextFieldDelegate) {
        deckNameTextField.text = text
        deckNameTextField.tag = tag
        deckNameTextField.delegate = delegate
    }
    
    private func setupUI() {
        deckLabel.numberOfLines = 0
        deckLabel.adjustsFontSizeToFitWidth = false
        deckLabel.anchor(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        deckNameTextField.anchor(top: deckLabel.bottomAnchor, paddingTop: 10, bottom: bottomAnchor, paddingBottom: 5, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        
    }
    
    private func setSubviews() {
        contentView.addSubview(deckLabel)
        contentView.addSubview(deckNameTextField)
    }
}



