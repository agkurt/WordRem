//
//  UIComponentsHelper.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

struct UIComponentsHelper {
    static func createCustomLabel(text : String , size :CGFloat, labelBackGroundColor : UIColor , textColor : UIColor , fontName : String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont(name: fontName, size: size)
        label.backgroundColor = labelBackGroundColor
        label.textAlignment = .center
        label.textColor = textColor
        label.numberOfLines = 2
        return label
    }
    
    static func createCustomButton(buttonTitle : String , titleColor :UIColor , buttonBackGroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 15)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = buttonBackGroundColor
        button.layer.cornerRadius = 5
        return button
    }
    
    static func createImageView(imageName :String ) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }
    
    static func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }
    
    
}

