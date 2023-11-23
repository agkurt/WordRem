//
//  DetailViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 27.10.2023.
//

import UIKit

protocol SendTextFieldDelegate : AnyObject{
    func sendTextField(_ frontName :[String],_ backName :[String],_ cardDescription : [String])
}

class DetailViewController: UIViewController {
    
    private var frontName : [String] = [""]
    private var backName : [String] = [""]
    private var cardDescription : [String] = [""]
    private var cardInfo: [(front: String, back: String, description: String)] = [("","","")]
    private var tableView = UITableView()
    
    private let identifier = "detailCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
        sendTextField(frontName, backName, cardDescription)
        configureFirebaseData()
    }
    
    private func configureFirebaseData() {
        var cardModels: [CardNameModel] = []
        
        for info in cardInfo {
            let cardNameModel = CardNameModel(frontName: [info.front], backName: [info.back], cardDescription: [info.description])
            cardModels.append(cardNameModel)
        }
        
        AuthService.shared.addCardNameDataToFirebase(cardModels) { [weak self] error in
            guard let self = self else {return}
            if let error = error {
                print("wrong data \(error.localizedDescription)")
            }else {
                print("successfuly saved data")
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let vc = CardViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension DetailViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frontName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DetailTableViewCell else {
            fatalError("wrong identifier ")
        }
        let info = cardInfo[indexPath.row]
        cell.configureCell(delegate: self, frontText: info.front, tag: indexPath.row, backText: info.back, descriptionText: info.description)
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DetailTableViewCell else {
            fatalError("wrong identifier")
        }
        
           let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
           let tag = textField.tag
           
           if tag >= cardInfo.count {
               cardInfo.append(("", "", ""))
           }
           
           if textField == cell.frontTextField {
               cardInfo[tag].front = text
           } else if textField == cell.backTextField {
               cardInfo[tag].back = text
           } else if textField == cell.cardDescription {
               cardInfo[tag].description = text
           }
           
           return true
       }
}

extension DetailViewController : SendTextFieldDelegate {
    
    func sendTextField(_ frontName: [String], _ backName: [String], _ cardDescription: [String]) {
            cardInfo = [] // Önceki verileri temizle
            
            for i in 0..<frontName.count {
                let front = frontName[i]
                let back = backName[i]
                let description = cardDescription[i]
                cardInfo.append((front, back, description))
            }
        }
}
