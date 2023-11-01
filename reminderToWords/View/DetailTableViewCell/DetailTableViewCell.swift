//
//  DetailTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 27.10.2023.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    private let frontLabel = UIComponentsHelper.createCustomLabel(text: "Card Front", size: 15, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-Light")
    private let backLabel = UIComponentsHelper.createCustomLabel(text: "Card Back", size: 15, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-Light")
    private let labelStackView = UIComponentsHelper.createStackView(axis: .horizontal, spacing: 25 , distribution: .fillProportionally)
    private let textFieldStackView = UIComponentsHelper.createStackView(axis: .horizontal, spacing: 45, distribution: .fillProportionally)
    let frontTextField = UIComponentsHelper.createTextField(placeholder: "Card Front...", textColor: UIColor.black )
    let backTextField = UIComponentsHelper.createTextField(placeholder: "Card Back...", textColor: UIColor.black)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // for storyboard
    
    private func setupTableViewCell() {
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        contentView.addSubview(labelStackView)
        contentView.addSubview(textFieldStackView)
        labelStackView.addArrangedSubview(frontLabel)
        labelStackView.addArrangedSubview(backLabel)
        textFieldStackView.addArrangedSubview(frontTextField)
        textFieldStackView.addArrangedSubview(backTextField)
        
        frontTextField.layer.borderWidth = 0.5
        frontTextField.layer.borderColor = UIColor.black.cgColor
        frontTextField.layer.cornerRadius = 20
        
        backTextField.layer.borderWidth = 0.5
        backTextField.layer.borderColor = UIColor.black.cgColor
        backTextField.layer.cornerRadius = 20

        
        NSLayoutConstraint.activate([
            frontTextField.widthAnchor.constraint(equalToConstant: 160),
            frontTextField.heightAnchor.constraint(equalToConstant: 90),
            backTextField.widthAnchor.constraint(equalToConstant: 160),
            backTextField.heightAnchor.constraint(equalToConstant: 90),
        ])
        
    }
    
    private func configureUI() {
        labelStackView.anchor(top: self.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: self.leftAnchor, paddingLeft: 0, right: self.rightAnchor, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        textFieldStackView.anchor(top: labelStackView.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
    }
    
}
