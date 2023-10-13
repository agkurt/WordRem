//
//  CustomCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 13.10.2023.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    var wordsDecks: WordDecks!
    
    private let iv : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "car")
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let myLabel : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.text = "Error"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with image : UIImage , and label : String) {
        self.iv.image = image
        self.myLabel.text = label
    }
    private func setupUI() {
        
        self.contentView.addSubview(iv)
        self.contentView.addSubview(myLabel)
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iv.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            iv.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            iv.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor), // Bu satırı değiştirdik.           // iv.heightAnchor.constraint(equalToConstant: 90),
            iv.widthAnchor.constraint(equalToConstant: 90),
            
            myLabel.leadingAnchor.constraint(equalTo: self.iv.trailingAnchor , constant: 16),
            myLabel.trailingAnchor.constraint(equalTo: self.iv.trailingAnchor, constant: -8),
            myLabel.topAnchor.constraint(equalTo: self.iv.topAnchor),
            myLabel.bottomAnchor.constraint(equalTo: self.iv.bottomAnchor),
            
            
        ])
    }
    
}
