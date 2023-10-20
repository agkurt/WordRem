//
//  HomePageController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class HomePageController : UICollectionViewController {
    
    var homePageView : HomePageView!
    var wordsBrain = WordsBrain()
    // MARK - COMPOSITIONAL LAYOUT
    init() {
        super.init(collectionViewLayout: HomePageController.createLayout())
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
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .red
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .red
            return cell
        default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .red
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            let detailViewController = UIViewController()
            detailViewController.view.backgroundColor = .white
            detailViewController.title = " \(indexPath.row)"
            navigationController?.pushViewController(detailViewController, animated: true)
        default:
            let detailViewController = UIViewController()
            detailViewController.view.backgroundColor = .white
            detailViewController.title = " \(indexPath.row)"
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private let cellId = "cellId"
    
    private func setupUI() {
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        homePageView = HomePageView(frame: self.view.frame)
        self.view.addSubview(homePageView)
        title = "SMARTCARDS"
        addTargetButton()
        homePageView.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 370, height: 80, centerXAnchor: view.centerXAnchor, centerYAnchor: nil)
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
    
    
}

