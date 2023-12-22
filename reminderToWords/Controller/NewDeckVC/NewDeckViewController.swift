//
//  NewDeckViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 17.10.2023.
//



import UIKit

protocol ImagePickerDelegate : AnyObject {
    func didTapButton(_ button : UIButton)
}
protocol TextFieldDelegate: AnyObject {
    func sendTextFieldValue(deckNames: [String])
}

final class NewDeckViewController : UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    private var tableView = UITableView()
    var deckNames : [String] = [""]
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        setTableViewDelegate()
        tableView.register(NewDeckTableViewCell.self, forCellReuseIdentifier: "deckCell")
        configureNavigationbar()
        tableView.pin(to: view)
        tableView.separatorStyle = .none
        title = "New Deck"
        view.backgroundColor = UIColor.white
    }
    
    func checkEmptyTextField() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NewDeckTableViewCell else {
            fatalError("Wrong cell file")
        }
        
        guard let deckNameTextField = cell.deckNameTextField.text, !deckNameTextField.isEmpty else {
            print("Tüm alanları doldurunuz")
            return
        }
        
        let dataModel = DataModel(deckName: deckNames)
        AuthService.shared.addDataToFirebase(dataModel) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Wrong data \(error.localizedDescription)")
            } else {
                print("Successfully saved data")
                self.sendTextFieldValue(deckNames: self.deckNames)
            }
        }
    }
    
    @objc func doneButtonTapped() {
        checkEmptyTextField()
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureNavigationbar() {
        navigationItem.backButtonTitle = "Cancel"
        navigationItem.title = "New Deck"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let tag = textField.tag
        
        if tag >= deckNames.count {
            while tag >= deckNames.count {
                deckNames.append("")
            }
        }
        
        deckNames[tag] = text
        return true
    }
}

extension NewDeckViewController : UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "deckCell") as? NewDeckTableViewCell else {
                fatalError("Wrong cell file")
            }
            cell.configure(with: deckNames[indexPath.row], tag: indexPath.row, delegate: self)
            cell.backgroundColor = UIColor.white
            cell.selectionStyle = .none
            return cell
        default:
                // Boş bir hücre dön
                let emptyCell = UITableViewCell()
                emptyCell.backgroundColor = UIColor.white
                emptyCell.selectionStyle = .none
                return emptyCell
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 100
        default:
            return 200
        }
        
    }
    
}

extension NewDeckViewController : TextFieldDelegate {
    
    func sendTextFieldValue(deckNames: [String]) {
        let hasEmptyField = deckNames.contains { $0.isEmpty }
        if hasEmptyField {
            print("Tüm alanları doldurunuz")
        } else {
            let vc = TabBarController()
            navigationController?.popViewController(animated: true)
        }
    }
    
}
