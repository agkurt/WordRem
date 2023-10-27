//
//  DetailViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 27.10.2023.
//

import UIKit

class DetailViewController: UIViewController {

    private var tableView = UITableView()
    private let identifier = "detailCell"
    private var cellNumber : [Int] = []
    static let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        configureTableView()
        setupCell()
    }

    private func configureTableView() {
        self.view.addSubview(tableView)
        tableView.pin(to: view)
        self.view.backgroundColor = .white
    }
    
    private func setupCell() {
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: identifier)
    }

}

extension DetailViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DetailTableViewCell else {
            fatalError("wrong identifier ")
        }
        cell.backgroundColor = .blue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DetailTableViewCell else {
            fatalError("wrong identifier")
        }
        cell.backgroundColor = .blue
        
    }
    
    
}
