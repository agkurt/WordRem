//
//  DeckImageTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 19.10.2023.
//

import UIKit

class DeckImageTableViewCell: UITableViewCell {
    
    var delegate : ImagePickerDelegate?
    
    let deckImageLabel = UIComponentsHelper.createCustomLabel(text: "Deck Image", size: 15, labelBackGroundColor: .clear, textColor: UIColor.init(hex: "#3B5BA5"), fontName: "Poppins-SemiBold")
    var selectImageButton = UIComponentsHelper.createCustomButton(buttonTitle: "Add an a Image", titleColor: UIColor.init(hex: "#3B5BA5"), buttonBackGroundColor: .clear, UIColorName: "Poppins-Light")
    var image = UIComponentsHelper.createImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureDeckImageCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDeckImageCell() {
        setupViews()
        setupUI()
    }
    
    func updateImage(_ image: UIImage) {
        self.image.image = image
    }

    private func setupViews() {
        self.addSubview(deckImageLabel)
        contentView.addSubview(selectImageButton)
        self.addSubview(image)
        selectImageButton.addTarget(self, action: #selector(didTapSelectButton), for: .touchUpInside)
    }
    
    @objc func didTapSelectButton() {
        delegate?.didTapButton(selectImageButton)
        delegate?.didSelectButtonInCell(self)
    }
    
    private func setupUI() {
        deckImageLabel.anchor(top: self.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        selectImageButton.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: image.centerXAnchor, centerYAnchor: image.centerYAnchor)
        image.anchor(top: deckImageLabel.bottomAnchor, paddingTop: 10, bottom: bottomAnchor, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: rightAnchor, paddingRight: 10, width: 0, height: 0, centerXAnchor: centerXAnchor, centerYAnchor: nil)
    }

}

