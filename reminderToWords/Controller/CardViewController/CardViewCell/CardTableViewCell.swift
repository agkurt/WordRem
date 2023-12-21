//
//  CardTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 24.11.2023.
//

import UIKit
import SwipeCellKit

class CardTableViewCell :SwipeCollectionViewCell {
    
    
    public let word = UIComponentsHelper.createCustomLabel(text: "", size: 25, labelBackGroundColor: UIColor.clear, textColor: UIColor.white, fontName: "Poppins-SemiBold")
    let wordMean = UIComponentsHelper.createCustomLabel(text: "", size: 25, labelBackGroundColor: UIColor.clear, textColor: UIColor.white, fontName: "Poppins-SemiBold")
    let wordDescription = UIComponentsHelper.createCustomLabel(text: "", size: 15, labelBackGroundColor: UIColor.clear, textColor: UIColor.white, fontName: "Poppins-SemiBold")
    let wordLabel = UIComponentsHelper.createCustomLabel(text: "Word", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.black, fontName: "Poppins-SemiBold")


    var isFrontShowing = true
    let selectLabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isEditing:Bool = false {
        didSet{
            selectLabel.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectLabel.text = isSelected ? "✔︎" : ""
            }
        }
    }

    private func setupViewCell() {
        addSubview(wordMean)
        addSubview(wordDescription)
        addSubview(word)
        configureSelectedLabel()
        
        wordMean.anchor(top: topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        
        wordDescription.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 25, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        
        word.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor)
        
        selectLabel.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 5, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 5, width: 30, height: 30, centerXAnchor: nil, centerYAnchor: nil)
  
        wordDescription.numberOfLines = 3
  
    }
    
    private func configureSelectedLabel() {
        addSubview(selectLabel)
        selectLabel.layer.cornerRadius = 15
        selectLabel.layer.masksToBounds = true
        selectLabel.isHidden = true
        selectLabel.text = ""
        selectLabel.layer.borderColor = UIColor.white.cgColor
        selectLabel.layer.borderWidth = 1.0
        selectLabel.textAlignment = .center
        selectLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        selectLabel.textColor = .white
        selectLabel.font = UIFont(name: "", size: 25)
        selectLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(_ wordText: String,_ wordMeanText: String,_ wordDescriptionText: String) {
        word.text = wordText
        wordMean.text = wordMeanText
        wordDescription.text = wordDescriptionText
    }
}


