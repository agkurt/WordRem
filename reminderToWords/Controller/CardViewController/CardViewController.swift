//
//  CardViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 1.11.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class CardViewController: UICollectionViewController {
    
    var frontName : [String] = []
    var backName : [String] = []
    var cardDescription : [String] = []
    var fetchedCardNameModels: [String] = []
    public var deckId : String = ""
    public var deckNames : [String] = []
    var selectedCells: Set<Int> = []
    var cardView = CardView()
    public var cardId :String = ""
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
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didtapBackButton))
        navigationItem.rightBarButtonItems = [
            editButtonItem,
            UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(didTapTrashButton))

        ]
    }
    
    @objc private func didTapTrashButton(_ sender : UIButton) {
        print("tıklandı")
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        
        collectionView.indexPathsForSelectedItems?.forEach({ (indexPath) in
            collectionView.deselectItem(at: indexPath, animated: false)
        })
        collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cell = collectionView.cellForItem(at: indexPath) as! CardTableViewCell
            cell.isEditing = editing
        }
       
    }
    private func deleteSelectedItems(_ sender: UIBarButtonItem) {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            let items = selectedItems.map { $0.item }.sorted().reversed()
            for item in items {
                fetchedCardNameModels.remove(at: item)
            }
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
            vc.cardId = self.cardId
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
                cardId = document.documentID
                print("selamss - \(cardId)")
                print("Card Document ID: \(document.documentID), Data: \(deckData)")
                
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
        cell.word.text = fetchedCardNameModels[indexPath.row]
        cell.isEditing = isEditing
        cell.backgroundColor = UIColor.random
        cell.configure(frontName[indexPath.row], backName[indexPath.row], cardDescription[indexPath.row])
        cell.layer.cornerRadius = 20
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            let selectedData = fetchedCardNameModels[indexPath.row]
        }
    }

}
