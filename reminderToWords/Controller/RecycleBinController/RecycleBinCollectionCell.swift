//
//  RecycleBinCollectionCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 20.12.2023.
//

import UIKit

class RecycleBinCollectionCell : UICollectionViewCell {
    
    let word = UIComponentsHelper.createCustomLabel(text: "", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.white, fontName: "Poppins-SemiBold")
    let wordMean = UIComponentsHelper.createCustomLabel(text: "", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.white, fontName: "Poppins-SemiBold")
    let wordDescription = UIComponentsHelper.createCustomLabel(text: "", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.white, fontName: "Poppins-SemiBold")
    let selectLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
        configureSelectedLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isEditing :Bool = false {
        didSet{
            selectLabel.isHidden = !isEditing
            return
        }
    }
    
    
    func configure(_ frontName: String, _ backName :String,_ cardDescription:String) {
        
        word.text = frontName
        word.textAlignment = .left
        wordMean.text = backName
        wordMean.textAlignment = .center
        wordDescription.text = cardDescription
        wordDescription.textAlignment = .right
       
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
        
        selectLabel.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 5, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 5, width: 30, height: 30, centerXAnchor: nil, centerYAnchor: nil)
        
    }
    
    private func setupViewCell() {
        addSubview(wordMean)
        addSubview(wordDescription)
        addSubview(word)
        
        wordMean.anchor(top: topAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 5, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        
        wordDescription.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 20, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        
        word.anchor(top: topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 5, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: wordMean.centerYAnchor)
    }
}
