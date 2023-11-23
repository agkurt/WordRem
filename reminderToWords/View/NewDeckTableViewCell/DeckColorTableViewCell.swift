//
//  DeckColorTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 19.10.2023.
//

import UIKit

class DeckColorTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureDeckColorCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDeckColorCell() {
        setupUI()
    }
    
    private func setupUI() {
        
    }
}
