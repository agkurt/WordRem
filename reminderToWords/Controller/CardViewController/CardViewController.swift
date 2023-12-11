//
//  CardViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 1.11.2023.
//

import UIKit
import Firebase
import FirebaseAuth


class CardViewController: UIViewController {
    
    public var frontName : [String] = []
    public var backName : [String] = []
    public var cardDescription : [String] = []
    var fetchedCardNameModels: [String] = []
    public var deckId : String = ""
    public var deckNames : [String] = []
    let tableView = UITableView()
    var cardView = CardView()
    public var cardId :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        print("veriler geldi")
        fetchCurrentUserDecksData()
        print("lastDeckId: \(deckId)")
        print("cardID : \(cardId)")
        print("fetch içerisi : \(fetchedCardNameModels)")
    }
    
    private func setupTableView() {
        configureTableView()
        configureNavigationItem()
        cardView = CardView(frame: self.view.frame)
        self.view.addSubview(cardView)
        configureCardView()
        cardView.createNewCard.addTarget(self, action: #selector(didTapNewCardButton), for: .touchUpInside)
        cardView.createNewCard.isUserInteractionEnabled = true
        title = "Cards"
    }
    
    private func configureNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didtapBackButton))
    }
    
    @objc private func didtapBackButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let vc = HomePageCollectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
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
            vc.deckId = self.deckId
            vc.deckName = self.deckNames
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func fetchCurrentUserDecksData() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userDecksRef = db.collection("users").document(currentUserUID).collection("decks").document(deckId).collection("cardName")
        
        userDecksRef.getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching deck data: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Deck not found")
                return
            }
            
            for document in snapshot.documents {
                let deckData = document.data()
                print("Deck Document ID: \(document.documentID), Data: \(deckData)")
                                
                if let frontNames = deckData["frontName"] as? [String],
                   let backNames = deckData["backName"] as? [String],
                   let cardDescriptions = deckData["cardDescription"] as? [String] {
                    
                    self.fetchedCardNameModels.append(contentsOf: frontNames)
                    self.fetchedCardNameModels.append(contentsOf: backNames)
                    self.fetchedCardNameModels.append(contentsOf: cardDescriptions)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Reloaded TableView")
                print("Card Name Count: \(self.fetchedCardNameModels.count)")
            }
        }
    }
}

extension CardViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCardNameModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as? CardTableViewCell else {
            fatalError("wrong identifier")
        }
        cell.configure(text: fetchedCardNameModels[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}

extension CardViewController: SendTextFieldDelegate {
    func sendTextField(_ frontName: [String], _ backName: [String], _ cardDescription: [String], _ fetchedCardNameModels: [String]) {
        self.frontName = frontName
        self.backName = backName
        self.cardDescription = cardDescription
    }
}
