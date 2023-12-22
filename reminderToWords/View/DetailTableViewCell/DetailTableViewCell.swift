//
//  DetailTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 27.10.2023.
//

import UIKit


class DetailTableViewCell: UITableViewCell, UITextFieldDelegate {
  
        
    private let frontLabel = UIComponentsHelper.createCustomLabel(text: "Card Front", size: 15, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-Light")
    private let backLabel = UIComponentsHelper.createCustomLabel(text: "Card Back", size: 15, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-Light")
    private let descriptionLabel = UIComponentsHelper.createCustomLabel(text: "Card Description", size: 15, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-Light")
    public let frontTextField = UIComponentsHelper.createTextField(placeholder: "Front card", textColor: UIColor.black, backgroundColor: UIColor.clear)
    public let backTextField = UIComponentsHelper.createTextField(placeholder: "Back card", textColor: UIColor.black, backgroundColor: UIColor.clear)
    public let cardDescription = UIComponentsHelper.createTextField(placeholder: "Description", textColor: UIColor.black, backgroundColor: UIColor.clear)
    
    public var fetchedCardNameModels : [String] = []
    
    weak var delegate :SendTextFieldDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableViewCell()
       
    }
        required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupTableViewCell() {
        setupUI()
        configureUI()
    }

    
    public func configureCell(delegate : SendTextFieldDelegate , frontText: String,tag :Int, backText: String, descriptionText: String) {
        
        frontTextField.text = frontText
        backTextField.text = backText
        cardDescription.text = descriptionText
        
        frontTextField.tag = tag
        backTextField.tag = tag
        cardDescription.tag = tag
        
        frontTextField.delegate = delegate as? UITextFieldDelegate
        backTextField.delegate = delegate as? UITextFieldDelegate
        cardDescription.delegate = delegate as? UITextFieldDelegate
    
    }
    
    private func setupUI() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(frontLabel)
        contentView.addSubview(backLabel)
        contentView.addSubview(frontTextField)
        contentView.addSubview(backTextField)
        contentView.addSubview(cardDescription)
    }
    
    private func configureUI() {
        frontLabel.anchor(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        backLabel.anchor(top: frontTextField.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        descriptionLabel.anchor(top: backTextField.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        frontTextField.anchor(top: frontLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        backTextField.anchor(top: backLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left:leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        cardDescription.anchor(top: descriptionLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        
        frontTextField.layer.borderWidth = 1.0
        frontTextField.layer.borderColor = UIColor.gray.cgColor
        frontTextField.layer.cornerRadius = 10
        
        backTextField.layer.borderWidth = 1.0
        backTextField.layer.borderColor = UIColor.gray.cgColor
        backTextField.layer.cornerRadius = 10
        
        cardDescription.layer.borderWidth = 1.0
        cardDescription.layer.borderColor = UIColor.gray.cgColor
        cardDescription.layer.cornerRadius = 10
    }
}
