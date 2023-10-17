//
//  NewDeckViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 17.10.2023.
//

import UIKit

class NewDeckViewController : UIViewController {
    
    var deckView = NewDeckView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureNavigationbar()
        deckView = NewDeckView(frame : self.view.frame)
        self.view.addSubview(deckView)
    }
    
    @objc func doneButtonTapped() {
        print("agk")
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureNavigationbar() {
        navigationItem.backButtonTitle = "Cancel"
        navigationItem.title = "New Deck"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }
}
