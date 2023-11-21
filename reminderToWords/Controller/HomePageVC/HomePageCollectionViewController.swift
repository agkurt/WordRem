//
//  HomePageController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit
import FirebaseFirestore
import Firebase

class HomePageCollectionViewController : UICollectionViewController {
    
    var homePageView : HomePageView!
    let newdeckvc = NewDeckViewController()
    var deckNames : [String] = []
    
    // MARK - COMPOSITIONAL LAYOUT
    
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
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(deckNames.count)
        return deckNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deckCell", for: indexPath) as?  DeckCellCollectionViewCell else {
            fatalError("")
        }
        cell.configure(text: deckNames[indexPath.row])
        return cell
        
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CardViewController()
        vc.title = " \(indexPath.row)"
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

            var fetchedDeckNames: [String] = []

            for document in snapshot.documents {
                let deckData = document.data()
                print("Deck Document ID: \(document.documentID), Data: \(deckData)")

                if let deckNameArray = deckData["deckName"] as? [String] {
                    for deckName in deckNameArray {
                        fetchedDeckNames.append(deckName)
                    }
                }

            }

            // Assign the fetched data to deckNames array
            self.deckNames = fetchedDeckNames
            print("Fetched Deck Names: \(self.deckNames)") // Add this line to check the value

            // Reload collectionView on the main thread after fetching all data
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                print("Reloaded CollectionView")
                print("Deck Names Count: \(self.deckNames.count)") // Check the count after reloading
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
        title = "ReminderToWords"
        addTargetButton()
        homePageView.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 370, height: 80, centerXAnchor: view.centerXAnchor, centerYAnchor: nil)
        navigatorControllerSet()
    }
    
    private func addTargetButton() {
        homePageView.newCardButton.addTarget(self, action: #selector(newCardButtonTapped), for: .touchUpInside)
        homePageView.importButton.addTarget(self, action: #selector(importButtonTapped), for: .touchUpInside)
        homePageView.infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }
    
    @objc func newCardButtonTapped() {
        let vc = NewDeckViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func importButtonTapped() {
        let vc = ImportViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func infoButtonTapped() {
        print("infoButtonTapped tapped")
    }
    
    private func navigatorControllerSet() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogoutButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.orange
    }
    
    @objc func didTapLogoutButton() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else {return}
            if let error = error {
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
