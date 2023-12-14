//
//  ProfileView.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 14.12.2023.
//

import UIKit

class ProfileView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var view: UIView = {
       let view = UIView()
        return view
    }()
    
    lazy var button: UIButton =  {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupView() {
        backgroundColor = .white
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
