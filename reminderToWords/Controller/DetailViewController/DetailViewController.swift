//
//  DetailViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 27.10.2023.
//

import UIKit

protocol SendTextFieldDelegate : AnyObject{
    func sendTextField(_ frontName :[String],_ backName :[String],_ cardDescription : [String],_ fetchedCardNameModels : [String])
}

class DetailViewController: UIViewController {
        
    private var frontName : [String] = [""]
    private var backName : [String] = [""]
    private var cardDescription : [String] = [""]
    private var fetchedCardNameModels : [String] = [""]
    public var deckName : [String] = [""]
    public var homePageVc = HomePageCollectionViewController()
    private var tableView = UITableView()
    public var deckId :String = ""
    public var cardId : String = ""
    private let identifier = "detailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        print("detailviewcontroller deckId \(deckId)")
    }
    
    private func setupTableView() {
        configureTableView()
        setupCell()
        setTableViewDelegate()  
    }
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.backgroundColor = .white
        configureNavigationController()
    }
    
    private func setupCell() {
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDoneButton))
   
    }
    
    @objc private func didTapDoneButton() {
        configureFirebaseData()
    }
    
   
    
    private func configureFirebaseData() {
        let cardNameModel  = CardNameModel(frontName: frontName, backName: backName, cardDescription: cardDescription, cardId: cardId)
        AuthService.shared.addCardNameDataToFirebase(cardNameModel, deckId: deckId) {  error in
            if let error = error {
                print("wrong data \(error.localizedDescription)")
            }else {
                print("successfuly saved data")
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let vc = CardViewController()
            vc.cardId = self.cardId
            vc.deckId = self.deckId
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DetailViewController : UITableViewDelegate , UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCardNameModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DetailTableViewCell else {
            fatalError("wrong identifier ")
        }
        cell.configureCell(delegate: self, frontText: frontName[indexPath.row], tag: indexPath.row, backText: backName[indexPath.row], descriptionText: cardDescription[indexPath.row])
        
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DetailTableViewCell else {
            fatalError("wrong identifier")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let cell = textField.superview?.superview as? DetailTableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return false
        }
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == cell.frontTextField {
            frontName[indexPath.row] = text
        } else if textField == cell.backTextField {
            backName[indexPath.row] = text
        } else if textField == cell.cardDescription {
            cardDescription[indexPath.row] = text
        }
        
        return true
    }
}

extension DetailViewController : SendTextFieldDelegate {
    func sendTextField(_ frontName: [String], _ backName: [String], _ cardDescription: [String], _ fetchedCardNameModels: [String]) {
        let vc = CardViewController()
        vc.frontName = frontName
        vc.backName = backName
        vc.cardDescription = cardDescription
        vc.fetchedCardNameModels = fetchedCardNameModels
    }
}

