//
//  DetailTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 27.10.2023.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // for storyboard
    
    private func setupTableViewCell() {
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .black
    }
    
}
