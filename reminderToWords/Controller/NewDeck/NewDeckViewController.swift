//
//  NewDeckViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 17.10.2023.
//

import UIKit

class NewDeckViewController : UIViewController {
    
    var tableView = UITableView()
    var newDeckView = NewDeckView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        self.view.addSubview(newDeckView)
        self.view.addSubview(tableView)
        tableView.rowHeight = 50
        setTableViewDelegate()
        tableView.register(NewDeckTableViewCell.self, forCellReuseIdentifier: "deckCell")
        configureNavigationbar()
        newDeckView.pin(to: view)
        configureView()
        title = "New Deck"
    }
    
    @objc func doneButtonTapped() {
        print("agk")
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        tableView.anchor(top: view.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, paddingRight: 20, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: view.centerYAnchor)
    }
    
    private func configureNavigationbar() {
        navigationItem.backButtonTitle = "Cancel"
        navigationItem.title = "New Deck"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension NewDeckViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "deckCell") as? NewDeckTableViewCell else {
            fatalError("Wrong cell file")
        }
        return cell
    }
    
    
}

