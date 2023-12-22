//
//  RecycleBinController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 20.12.2023.
//

import UIKit
import Firebase
import FirebaseFirestore


class SuccessCardController : UICollectionViewController {
    
    public var deckId : String = ""
    private var recycleData: [String:Any] = [:]
    var recycleBinId = ""
    private var recycleModel : [String] = []
    private var word : [String] = []
    private var wordMean : [String] = []
    private var wordDescription : [String] = []
    var showingFront = true
    
    private lazy var emptyLabel : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "You don't have any cards memorized, go back and create your cards and memorize them ☻"
        label.textColor = .gray
        label.center = view.center
        return label
    }()

    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchedFromFirebaseDeleteItems()
    }
    
    private func configureCollectionView() {
        collectionView.register(SuccessCardViewCell.self, forCellWithReuseIdentifier: "recycleCell")
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
                recycleData = document.data()
                if let frontName = recycleData["frontName"] as? [String],
                   let backName = recycleData["backName"] as? [String],
                   let cardDescription = recycleData["cardDescription"] as? [String] {
                    word.append(contentsOf: frontName)
                    wordMean.append(contentsOf: backName)
                    wordDescription.append(contentsOf: cardDescription)
                    recycleBinId.append(document.documentID)
                }
                
            }
            collectionView.reloadData()
        }
    }
    
}

extension SuccessCardController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if word.isEmpty {
            collectionView.backgroundView = emptyLabel
        } else {
            collectionView.backgroundView = nil
        }
        return word.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recycleCell", for: indexPath) as? SuccessCardViewCell else {
            fatalError("wrong identifier")
        }
        cell.configure(word[indexPath.row],wordMean[indexPath.row], wordDescription[indexPath.row])
        cell.backgroundColor = UIColor.next
        cell.word.isHidden = false
        cell.wordMean.isHidden = true
        cell.wordDescription.isHidden = true
        cell.layer.cornerRadius = 20
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as?
                SuccessCardViewCell else {return}
        
        UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromTop, animations: {
            if self.showingFront {
                cell.wordMean.text = self.wordMean[indexPath.row]
                cell.wordDescription.text = self.wordDescription[indexPath.row]
                cell.word.isHidden = true
                cell.wordMean.isHidden = false
                cell.wordDescription.isHidden = false
                
                self.showingFront = false
            } else {
                cell.word.text = self.word[indexPath.row]
                cell.wordDescription.text = ""
                
                cell.word.isHidden = false
                cell.wordMean.isHidden = true
                cell.wordDescription.isHidden = true
                
                self.showingFront = true
            }
        }, completion: nil)
    }
}

   
