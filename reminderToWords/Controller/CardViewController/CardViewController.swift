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
    
    var frontName : [String] = []
    var backName : [String] = []
    var cardDescription : [String] = []
    var fetchedCardNameModels: [String] = []
    public var deckId : String = ""
    public var deckNames : [String] = []
    let tableView = UITableView()
    var cardView = CardView()
    public var cardId :String = ""
    var deletedItems: (frontName: String, backName: String, cardDescription: String)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchCurrentUserDecksData()
        title = "Cards"
        
    }

    private func setupTableView() {
        configureTableView()
        configureNavigationItem()
        cardView = CardView(frame: self.view.frame)
        self.view.addSubview(cardView)
        configureCardView()
        cardView.createNewCard.addTarget(self, action: #selector(didTapNewCardButton), for: .touchUpInside)
        cardView.createNewCard.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
    }
    
    private func configureNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didtapBackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Undo", style: .plain, target: self, action: #selector(undoButton))
    }
    
    @objc private func undoButton() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        let db = Firestore.firestore()
        let deletedItemsRef = db.collection("users").document(currentUserUID).collection("decks").document(deckId).collection("deletedItems")
        
        deletedItemsRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching deleted items: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            for document in snapshot.documents {
                let deletedFrontName = document.get("frontName") as? String ?? ""
                let deletedBackName = document.get("backName") as? String ?? ""
                let deletedCardDescription = document.get("cardDescription") as? String ?? ""
                
                document.reference.delete()
                
                self.frontName.append(deletedFrontName)
                self.backName.append(deletedBackName)
                self.cardDescription.append(deletedCardDescription)
            }
            
            // TableView'i yenile
            self.tableView.reloadData()
        }
    }
    
    func update(with deckId: String) {
            self.deckId = deckId
           
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
                    
                    self.frontName.append(contentsOf: frontNames)
                    self.backName.append(contentsOf: backNames)
                    self.cardDescription.append(contentsOf: cardDescriptions)
                    
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
