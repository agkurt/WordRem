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


class CardViewController: UICollectionViewController {

    var frontName : [String] = []
    var backName : [String] = []
    var cardDescription : [String] = []
    public var deckId : String = ""
    public var deckNames : [String] = []
    var cardView = CardView()
    public var cardIds : String = ""
    var deletedItems: (frontName: String, backName: String, cardDescription: String)?
    var showingFront = true
    let refreshController = UIRefreshControl()
    
    
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
        fetchCurrentUserCardsData()
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
            //editButtonItem,
            UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(didTapRecycleButton))
            
        ]
    }
    
    @objc private func didTapRecycleButton() {
        let vc = RecycleBinController()
        vc.deckId = deckId
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func update(with deckId: String) {
        self.deckId = deckId
    }
    
    @objc private func didtapBackButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.pin(to: view)
        collectionView.register(CardTableViewCell.self, forCellWithReuseIdentifier: "cardCell")
        collectionView.refreshControl?.endRefreshing()
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
            vc.cardId = self.cardIds
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func fetchCurrentUserCardsData() {
        AuthService.shared.fetchCurrentUserCardsData(deckId: deckId) { frontNames, backNames, cardDescriptions,cardIds ,error  in
            if let error = error {
                // Hata durumunu ele al
                print("Error fetching card data: \(error.localizedDescription)")
                return
            }
            
            if let frontNames = frontNames, let backNames = backNames, let cardDescriptions = cardDescriptions, let cardIds = cardIds {
                self.frontName = frontNames
                self.backName = backNames
                self.cardDescription = cardDescriptions
                self.cardIds = cardIds
                
                //                NotificationProvider.scheduleNotification(title: "WordMean", date: <#T##Date#>, id: <#T##String#>, word: <#T##String#>, wordMean: <#T##String#>, wordDescription: <#T##String#>)
                self.collectionView.reloadData()
            }
        }
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        collectionView.indexPathsForVisibleItems.forEach { indexPath in
            if let cell = collectionView.cellForItem(at: indexPath) as? CardTableViewCell {
                cell.isEditing = editing
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardTableViewCell else {
            fatalError("")
        }
        cell.delegate = self
        
        
        cell.configure(frontName[indexPath.row], backName[indexPath.row], cardDescription[indexPath.row])
        cell.isEditing = isEditing
        cell.word.isHidden = false
        cell.wordMean.isHidden = true
        cell.wordDescription.isHidden = true
        cell.backgroundColor = UIColor.random
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cardIds içeriği \(cardIds)")
       
            guard let cell = collectionView.cellForItem(at: indexPath) as?
                    CardTableViewCell else {return}
            
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromTop, animations: {
                if self.showingFront {
                    cell.wordMean.text = self.backName[indexPath.row]
                    cell.wordDescription.text = self.cardDescription[indexPath.row]
                    
                    cell.word.isHidden = true
                    cell.wordMean.isHidden = false
                    cell.wordDescription.isHidden = false
                    
                    self.showingFront = false
                } else {
                    cell.word.text = self.frontName[indexPath.row]
                    cell.wordDescription.text = ""
                    
                    cell.word.isHidden = false
                    cell.wordMean.isHidden = true
                    cell.wordDescription.isHidden = true
                    
                    self.showingFront = true
                }
            }, completion: nil)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frontName.count
    }
    
}

extension CardViewController : SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            AuthService.shared.deleteCardFromFirebase(cardID: self.cardIds) { error in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                }
                self.frontName.remove(at: indexPath.row)
                self.backName.remove(at: indexPath.row)
                self.cardDescription.remove(at: indexPath.row)
                collectionView.reloadData()
                action.fulfill(with: .delete)
                action.image = UIImage(named: "delete")
            }
        }
        
        return [deleteAction]
    }

    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
}
    
   
