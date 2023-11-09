//
//  HomePageController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class HomePageCollectionViewController : UICollectionViewController {
    
    var homePageView : HomePageView!
    let newdeckvc = NewDeckViewController()
    var values: [String] = []
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
        return values.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deckViewCell", for: indexPath) as! DeckCellCollectionViewCell
            cell.backgroundColor = .lightGray
            cell.configure(with: values[indexPath.item])
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .lightGray
            return cell
        default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .lightGray
            return cell
        }
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
        setupUI()
        collectionView.register(DeckCellCollectionViewCell.self, forCellWithReuseIdentifier: "deckViewCell")
    }
    
    private let cellId = "cellId"
    
    private func setupUI() {
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
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
