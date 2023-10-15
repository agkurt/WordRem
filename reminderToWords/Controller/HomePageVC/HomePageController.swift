//
//  HomePageController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class HomePageController : UICollectionViewController {
    
    var homePageView : HomePageView!
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
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            let detailViewController = UIViewController() // Veya farklı bir ViewController sınıfı
            detailViewController.view.backgroundColor = .white
            detailViewController.title = "Detay \(indexPath.row)"
            
            // Şimdi bu yeni ViewController'ı gösterelim
            navigationController?.pushViewController(detailViewController, animated: true)
        default:
            let detailViewController = UIViewController() // Veya farklı bir ViewController sınıfı
            detailViewController.view.backgroundColor = .white
            detailViewController.title = "Detay \(indexPath.row)"
            
            // Şimdi bu yeni ViewController'ı gösterelim
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
        homePageView = HomePageView(frame: self.view.frame)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        title = "SMARTCARDS"
        homePageView.infoButton.removeFromSuperview()
        view.addSubview(homePageView.infoButton)
        view.bringSubviewToFront(homePageView.infoButton)
        self.view.addSubview(homePageView.viewForButton)
        self.view.addSubview(homePageView.stackViewButtons)
       
       
        configureUI()
        
    }
    
    private func configureUI() {
        homePageView.infoButton.anchor(top: view.topAnchor, paddingTop: 55, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 8, width: 50, height: 50 , centerXAnchor: nil , centerYAnchor: nil)
        homePageView.stackViewButtons.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 20, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 350, height: 80, centerXAnchor: view.centerXAnchor, centerYAnchor: nil)
        homePageView.viewForButton.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 0, right: view.rightAnchor, paddingRight: 0, width: 0, height: 100, centerXAnchor: view.centerXAnchor, centerYAnchor: nil)
    }
}
