//
//  DeckCellCollectionViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 25.10.2023.
//

import UIKit

class DeckCellCollectionViewCell: UICollectionViewCell {
    var label: UILabel!
    
    // Cell'in içeriğini ayarlayan bir fonksiyon tanımlıyoruz
    func configure(with text: String) {
        
        // Label nesnesini oluşturuyoruz
        label = UILabel()
        
        // Label'ın özelliklerini belirliyoruz
        label.text = text
        label.textAlignment = .center
        
        // Label'ı cell'in contentView'ine ekliyoruz
        contentView.addSubview(label)
        
        // Label'ın konumunu ve boyutunu belirliyoruz
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
