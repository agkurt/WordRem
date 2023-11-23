//
//  CardView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 1.11.2023.
//

import UIKit

class CardView: UIView {
    
    let createNewCard = UIComponentsHelper.createCustomButton(buttonTitle: "Create New Card", titleColor: UIColor.white, buttonBackGroundColor: UIColor.blue, UIColorName: "Poppins-SemiBold")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func configureView() {
        setSubviews()
        setupUI()
    }
    
    private func setSubviews() {
        addSubview(createNewCard)
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            createNewCard.widthAnchor.constraint(equalToConstant: 200),
            createNewCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            createNewCard.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
