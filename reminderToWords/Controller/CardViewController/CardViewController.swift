//
//  CardViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 1.11.2023.
//

import UIKit

class CardViewController: UIViewController {
    
    public var frontName : [String] = []
    public var backName : [String] = []
    public var cardDescription : [String] = []
    
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
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "cardCell")
        
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let vc = DetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension CardViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frontName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as? CardTableViewCell else {
            fatalError("wrong identifier")
        }
        cell.configure(text: frontName[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        return cell
    }
    
    
}

extension CardViewController: SendTextFieldDelegate {
    func sendTextField(_ frontName: [String], _ backName: [String], _ cardDescription: [String]) {
        self.frontName = frontName
        self.backName = backName
        self.cardDescription = cardDescription
    }
    
    
}
