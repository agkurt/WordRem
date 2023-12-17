//
//  CardViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 1.11.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import SwipeCellKit

class CardViewController: UICollectionViewController, SwipeCollectionViewCellDelegate {
    
    var frontName : [String] = []
    var backName : [String] = []
    var cardDescription : [String] = []
    var fetchedCardNameModels: [String] = []
    public var deckId : String = ""
    public var deckNames : [String] = []
    var cardView = CardView()
    public var cardId :String = ""
    var options = SwipeTableOptions()
    var deletedItems: (frontName: String, backName: String, cardDescription: String)?
    
    init() {
        super.init(collectionViewLayout: CardViewController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) ->
            NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 15
            item.contentInsets.leading = 15
            item.contentInsets.bottom = 15
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        options.expansionStyle = .destructive(automaticallyDelete: false)
        fetchCurrentUserDecksData()
        title = "Cards"
    }
    
    private func setupTableView() {
        configureCollectionView()
        configureNavigationItem()
        self.view.addSubview(cardView)
        configureCardView()
        cardView.btnMiddle.addTarget(self, action: #selector(didTapbtnMiddleButton), for: .touchUpInside)
        
    }
    
    private func configureNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didtapBackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Undo", style: .plain, target: self, action: #selector(undoButton))
    }
    
    @objc private func undoButton() {
        fetchedFirebaseDeletedItemsData()
    }
    
    func fetchedFirebaseDeletedItemsData() {
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
            
            self.collectionView.reloadData()
        }
    }
    
    func update(with deckId: String) {
        self.deckId = deckId
        
    }
    
    @objc private func didtapBackButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let vc = TabBarController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.pin(to: view)
        collectionView.register(CardTableViewCell.self, forCellWithReuseIdentifier: "cardCell")
    }
    
    func performCardAddAction() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 60),
            cardView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func didTapbtnMiddleButton() {
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
                self.collectionView.reloadData()
                print("Reloaded CollectionView")
                print("Card Name Count: \(self.fetchedCardNameModels.count)")
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frontName.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardTableViewCell else {
            fatalError("")
        }
        cell.delegate = self
        cell.backgroundColor = UIColor.random
        cell.configure(frontName[indexPath.row], backName[indexPath.row], cardDescription[indexPath.row])
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.frontName.remove(at: indexPath.row)
            self.backName.remove(at: indexPath.row)
            self.cardDescription.remove(at: indexPath.row)
            action.fulfill(with: .delete)
        }
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }

}

