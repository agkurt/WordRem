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
    
    static func createView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }
    
    static func createTextField(placeholder : String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = ""
        textField.placeholder = placeholder
        textField.font = UIFont(name: "Poppins-Light", size: 12)
        textField.textColor = .white
        textField.isUserInteractionEnabled = true
        return textField
    }
    
    static func createLabel(text : String , size : CGFloat , fontName : String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont(name: fontName, size: size)
        label.textColor = UIColor.darkGray
        label.isUserInteractionEnabled = false
        return label
    }
    
}


