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
    
    static func createCustomButton(buttonTitle : String , titleColor :UIColor , buttonBackGroundColor: UIColor, UIColorName:String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: UIColorName, size: 15)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = buttonBackGroundColor
        button.layer.cornerRadius = 5
        return button
    }
    
    static func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "questionmark")
        imageView.tintColor = .label
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }
    
    static func createStackView(axis : NSLayoutConstraint.Axis , spacing : CGFloat , distribution :UIStackView.Distribution ) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .center
        stackView.spacing = spacing
        stackView.distribution = distribution
        return stackView
    }
    
    static func createView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }
    
    static func createTextField(placeholder : String ,textColor :UIColor) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = ""
        textField.placeholder = placeholder
        textField.font = UIFont(name: "Poppins-Light", size: 15)
        textField.textColor = textColor
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
    
    static func createPath() ->UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = 2.0
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 370, y: 0))
        return path
    }
    
    static func createDraw(startPoint: CGPoint, endPoint: CGPoint, strokeColor: UIColor = .gray, lineWidth: CGFloat = 1.0) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        return shapeLayer
    }
}


