//
//  CardView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 1.11.2023.
//

import UIKit

class CardView: UIView {
    
    lazy var btnMiddle : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.setTitle("", for: .normal)
        btn.backgroundColor = UIColor.mainBlue
        btn.layer.cornerRadius = 30
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.setBackgroundImage(UIImage(named: "add"), for: .normal)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func configureView() {
        setSubviews()
        setupUI()
    }
    
    private func setSubviews() {
        addSubview(btnMiddle)
    }
    
    private func setupUI() {
        btnMiddle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnMiddle.centerXAnchor.constraint(equalTo: centerXAnchor),
            btnMiddle.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant:-5),
            btnMiddle.widthAnchor.constraint(equalToConstant: 60),
            btnMiddle.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
