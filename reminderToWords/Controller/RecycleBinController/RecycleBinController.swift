//
//  RecycleBinController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 20.12.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class RecycleBinController : UICollectionViewController {
    
    public var deckId : String = ""
    private var recycleBinId = ""
    private var recycleData: [String:Any] = [:]
    private var recycleModel : [String] = []
    private var word : [String] = []
    private var wordMean : [String] = []
    private var wordDescription : [String] = []
    
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
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.register(RecycleBinCollectionCell.self, forCellWithReuseIdentifier: "recycleCell")
        configureNavigationItem()
    }
    
    private func configureNavigationItem() {
        navigationItem.rightBarButtonItem = editButtonItem
        
    }
    
    private func fetchedFromFirebaseDeleteItems() {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError("User not loggin in")
        }
        
        let db = Firestore.firestore()
        let ref = db.collection("users").document(uid).collection("decks").document(deckId).collection("deletedItems")
        
        ref.getDocuments { [weak self] snapshot, error in
            guard let self = self else {return}
            
            if let error = error {
                print("Error fetching deck data: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("deck not found")
                return
            }
            
            for document in snapshot.documents {
                recycleBinId = document.documentID
                recycleData = document.data()
                if let frontName = recycleData["frontName"] as? [String],
                   let backName = recycleData["backName"] as? [String],
                   let cardDescription = recycleData["cardDescription"] as? [String] {
                    word.append(contentsOf: frontName)
                    wordMean.append(contentsOf: backName)
                    wordDescription.append(contentsOf: cardDescription)
                }
                
            }
            collectionView.reloadData()
        }
    }
}

extension RecycleBinController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recycleCell", for: indexPath) as? RecycleBinCollectionCell else {
            fatalError("wrong identifier")
        }
        
        //cell.configure(word[indexPath.row],wordMean[indexPath.row], wordDescription[indexPath.row])
        cell.backgroundColor = UIColor.random
        cell.word.isHidden = false
        cell.wordMean.isHidden = true
        cell.wordDescription.isHidden = true
        cell.isEditing = isEditing
        cell.layer.cornerRadius = 20
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cell = collectionView.cellForItem(at: indexPath) as! RecycleBinCollectionCell
            cell.isEditing = editing
        }
    }
}
