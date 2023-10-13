//
//  HomePageController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.10.2023.
//

import UIKit

class HomePageController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var homePageVc : HomePageView!
    var wordsBrain = WordsBrain()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.register(DecksGroupController.self, forCellReuseIdentifier: "decksCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupUI() {
        
        homePageVc = HomePageView(frame: view.frame)
        self.view = homePageVc
        title = "SMARTCARDS"
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: homePageVc.infoButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: homePageVc.stackViewButtons.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsBrain.wordsDeck.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            fatalError("The tableview could not dequeue a CustomCell in ViewController")
        }
        let wordDeckItem = self.wordsBrain.wordsDeck[indexPath.row]
        
        // image özelliği zaten UIImage? tipinde, bu nedenle doğrudan kullanabiliriz.
        if let image = wordDeckItem.image {
            cell.configure(with: image, and: wordDeckItem.label)
        } else {
            print("Image not found for name: \(wordDeckItem.imageName)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        switch [indexPath.row]{
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        }
           self.navigationController?.pushViewController(DecksGroupController(), animated: true)
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.5
    }

    
}
