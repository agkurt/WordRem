//
//  CardViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 1.11.2023.
//

import UIKit

class CardViewController: UIViewController {
    
    let tableView = UITableView()
    var cardView = CardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        configureTableView()
        cardView = CardView(frame: self.view.frame)
        self.view.addSubview(cardView)
        configureCardView()
        cardView.createNewCard.addTarget(self, action: #selector(didTapNewCardButton), for: .touchUpInside)
        cardView.createNewCard.isUserInteractionEnabled = true
        title = "Cards"
    }
     
    private func configureTableView() {
        tableView.delegate  = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func configureCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 200),
            cardView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func didTapNewCardButton() {
        DispatchQueue.main.async {
            let vc = DetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CardViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            fatalError("wrong identifier")
        }
        cell.backgroundColor = .white
        return cell
    }
}
