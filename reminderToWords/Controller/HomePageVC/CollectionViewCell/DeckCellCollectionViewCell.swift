//
//  DeckCellCollectionViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 25.10.2023.
//

import UIKit

class DeckCellCollectionViewCell: UICollectionViewCell {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        
        label = UILabel()
        
        label.text = text
        label.textAlignment = .center
        
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
