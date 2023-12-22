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
    public var cardId: [String] = []
    var deletedItems: (frontName: String, backName: String, cardDescription: String)?
    var showingFront = true
    var activityIndicator =  UIActivityIndicatorView()
    var loadingView = UIView()
    
    private lazy var emptyLabel : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "Hiç kart eklemedin, hemen bir kart ekle ve ezberlemeye başla ☻"
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
        setupTableView()
        print("\(deckId)")
        print("buraya bak cardview cardıd\(cardId)")
        showSpinner()
        configureActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .plain, target: self, action: #selector(didTapRecycleButton))
            
        ]
    }
    
    @objc private func didTapRecycleButton() {
        let vc = SuccessCardController()
        vc.deckId = deckId
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }
    
    private func hideSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
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
            vc.cardId = self.cardId
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    private func configureActivityIndicator() {

        view.addSubview(activityIndicator)
        activityIndicator.style = .large
        view.addSubview(loadingView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
        ])
    }
    
    func fetchCurrentUserCardsData() {
        AuthService.shared.fetchCurrentUserCardsData(deckId: deckId) { frontNames, backNames, cardDescriptions,cardIds ,error  in
            if let error = error {
                self.hideSpinner()
                // Hata durumunu ele al
                print("Error fetching card data: \(error.localizedDescription)")
                return
            }
            
            if let frontNames = frontNames, let backNames = backNames, let cardDescriptions = cardDescriptions, let cardIds = cardIds {
                self.frontName = frontNames
                self.backName = backNames
                self.cardDescription = cardDescriptions
                self.cardId = cardIds
                self.collectionView.reloadData()
                self.hideSpinner()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardTableViewCell else {
            fatalError("")
        }
        cell.delegate = self
        
        cell.configure(frontName[indexPath.row], backName[indexPath.row], cardDescription[indexPath.row])
        cell.word.isHidden = false
        cell.wordMean.isHidden = true
        cell.wordDescription.isHidden = true
        cell.backgroundColor = UIColor.random
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
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
        if frontName.isEmpty {
            collectionView.backgroundView = emptyLabel
        } else {
            collectionView.backgroundView = nil
        }
        return frontName.count
    }
    
}

extension CardViewController : SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let cardNameModel = CardNameModel(frontName: frontName, backName: backName, cardDescription: cardDescription)
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            AuthService.shared.deleteCardFromFirebase(cardNameModel, cardID: self.cardId[indexPath.row], deckId: self.deckId) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            self.frontName.remove(at: indexPath.row)
            self.backName.remove(at: indexPath.row)
            self.cardDescription.remove(at: indexPath.row)
            action.fulfill(with: .delete)
            action.image = UIImage(named: "delete")
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

