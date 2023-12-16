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
    
    var homePageView : HomePageView!
    let newdeckvc = NewDeckViewController()
    var deckNames : [String] = []
    var deckIds : [String] = []
    var fetchedDeckNames: [String] = []
    
    
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
    
    func performHomeAddAction() {
        let addViewController = NewDeckViewController() // Burada "Home" view controller'a özel ekleme controller'ınızı oluşturun veya gösterin.
        navigationController?.pushViewController(addViewController, animated: true)
    }
    
    func fetchCurrentUserDecksData() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userDecksRef = db.collection("users").document(currentUserUID).collection("decks")
        
        userDecksRef.getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user decks: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("No decks available for this user")
                return
            }
            
            for document in snapshot.documents {
                let deckData = document.data()
                print("Deck Document ID: \(document.documentID), Data: \(deckData)")
                
                if let deckNameArray = deckData["deckName"] as? [String] {
                    for deckName in deckNameArray {
                        fetchedDeckNames.append(deckName)
                        deckIds.append(document.documentID)
                        print("deckID: \(deckIds)")
                    }
                }
            }
            
            self.deckNames = fetchedDeckNames
            print("Fetched Deck Names: \(self.deckNames)")
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                print("Reloaded CollectionView")
                print("Deck Names Count: \(self.deckNames.count)")
            }
        }
    }
    private let cellId = "cellId"
    
    private func setupUI() {
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(DeckCellCollectionViewCell.self, forCellWithReuseIdentifier: "deckCell")
        homePageView = HomePageView(frame: self.view.frame)
        self.view.addSubview(homePageView)
        addTargetButton()
        homePageView.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 370, height: 80, centerXAnchor: view.centerXAnchor, centerYAnchor: nil)
        navigatorControllerSet()
    }
    
    
    private func addTargetButton() {
        homePageView.infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }
    
    @objc func newCardButtonTapped() {
        let vc = NewDeckViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    @objc func infoButtonTapped() {
        print("infoButtonTapped tapped")
    }
    
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
