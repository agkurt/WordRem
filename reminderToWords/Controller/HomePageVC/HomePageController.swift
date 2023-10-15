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
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        title = "SMARTCARDS"
        configureButton()

    }
    
    private func configureButton() {
        let infoButton = UIComponentsHelper.createCustomButton(buttonTitle: "Info", titleColor: UIColor.darkGray, buttonBackGroundColor: .clear)
        let newCardButton = UIComponentsHelper.createCustomButton(buttonTitle: "Create New Flashcard Deck", titleColor: .white, buttonBackGroundColor: .blue)
        let importButton = UIComponentsHelper.createCustomButton(buttonTitle: "Import", titleColor: .white, buttonBackGroundColor: .blue)
        
        let stackViewButtons = UIStackView(arrangedSubviews: [newCardButton, importButton])
        stackViewButtons.axis = .horizontal
        stackViewButtons.distribution = .fillProportionally
        stackViewButtons.spacing = 8
        
        view.addSubview(stackViewButtons)
        view.addSubview(infoButton)
        
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .gray
        view.insertSubview(backgroundView, belowSubview: stackViewButtons)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
            infoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            infoButton.widthAnchor.constraint(equalToConstant: 50),
            infoButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackViewButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackViewButtons.widthAnchor.constraint(equalToConstant: 350),
            stackViewButtons.heightAnchor.constraint(equalToConstant: 80),
            
            backgroundView.centerXAnchor.constraint(equalTo: stackViewButtons.centerXAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: stackViewButtons.bottomAnchor),
            backgroundView.widthAnchor.constraint(equalTo: stackViewButtons.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: stackViewButtons.heightAnchor)
        ])
    }

}
