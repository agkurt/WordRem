//
//  HomePageController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit
import FirebaseFirestore
import Firebase

class HomePageCollectionViewController : UICollectionViewController,UITabBarDelegate {
    
    let newdeckvc = NewDeckViewController()
    var deckNames : [String] = []
    var deckIds : [String] = []
    var fetchedDeckNames: [String] = []
    var activityIndicator: UIActivityIndicatorView!
    
    init() {
        super.init(collectionViewLayout: HomePageCollectionViewController.createLayout())
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deckNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deckCell", for: indexPath) as?  DeckCellCollectionViewCell else {
            fatalError("")
        }
        cell.configure(text: deckNames[indexPath.row])
        cell.backgroundColor = UIColor.random
        cell.layer.cornerRadius = 20
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CardViewController()
        vc.deckId = deckIds[indexPath.row]
        vc.deckNames = deckNames
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupUI()
        fetchCurrentUserDecksData()
        
    }
    
    private func fetchCurrentUserDecksData() {
        AuthService.shared.fetchCurrentUserDecksData { fetchedDeckNames, deckIds, error in
            if let error = error {
                print("Error fetching deck data: \(error.localizedDescription)")
                return
            }
            
            if let fetchedDeckNames = fetchedDeckNames, let deckIds = deckIds {
                self.deckNames = fetchedDeckNames
                self.deckIds = deckIds
                self.collectionView.reloadData()
            }
        }
    }
    
    func performHomeAddAction() {
        let addViewController = NewDeckViewController()
        navigationController?.pushViewController(addViewController, animated: true)
    }
    
    
    private let cellId = "cellId"
    
    private func setupUI() {
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(DeckCellCollectionViewCell.self, forCellWithReuseIdentifier: "deckCell")
               
        navigatorControllerSet()
        createActivityIndicator()
    }
    
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    @objc func newCardButtonTapped() {
        let vc = NewDeckViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func infoButtonTapped() {
        print("infoButtonTapped tapped")
    }
    
    // incele
    private func navigatorControllerSet() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogoutButton))
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = "Decks"
    }
    
    @objc func didTapLogoutButton() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else {return}
            if let _ = error {
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}

extension HomePageCollectionViewController:TextFieldDelegate {
    
    func sendTextFieldValue(deckNames: [String]) {
        self.deckNames = deckNames
    }
}
