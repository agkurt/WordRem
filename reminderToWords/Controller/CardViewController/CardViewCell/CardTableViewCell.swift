//
//  CardTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 24.11.2023.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
     let word = UIComponentsHelper.createCustomLabel(text: "", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.orange, fontName: "Poppins-SemiBold")
     let wordMean = UIComponentsHelper.createCustomLabel(text: "", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.orange, fontName: "Poppins-SemiBold")
     let wordDescription = UIComponentsHelper.createCustomLabel(text: "", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.orange, fontName: "Poppins-SemiBold")
     let wordLabel = UIComponentsHelper.createCustomLabel(text: "Word", size: 20, labelBackGroundColor: UIColor.clear, textColor: UIColor.black, fontName: "Poppins-SemiBold")
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupViewCell() {
        contentView.addSubview(wordMean)
        contentView.addSubview(wordDescription)
        contentView.addSubview(word)

        wordMean.anchor(top: topAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 5, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        wordDescription.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 20, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        word.anchor(top: topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 5, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: wordMean.centerYAnchor)
        
    }
    
    func toggleReminder() {
            UIView.transition(with: word, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.word.isHidden = !self.word.isHidden
                self.wordMean.isHidden
                self.wordDescription.isHidden = !self.wordDescription.isHidden
            }, completion: nil)
        }
    
    func configure(_ wordText: String,_ wordMeanText: String,_ wordDescriptionText: String) {
        word.text = wordText
        word.textAlignment = .left
        wordMean.text = wordMeanText
        wordMean.textAlignment = .right
        wordDescription.text = wordDescriptionText
        wordDescription.textAlignment = .center
    
    }
}
