//
//  DetailViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 27.10.2023.
//

import UIKit

protocol SendTextFieldDelegate : AnyObject{
    func sendTextField(_ frontName :[String],_ backName :[String],_ cardDescription : [String],_ fetchedCardNameModels : [String], _ cardId: String)
}

class DetailViewController: UIViewController,SendTextFieldDelegate {

    
    private var frontName : [String] = [""]
    private var backName : [String] = [""]
    private var cardDescription : [String] = [""]
    private var fetchedCardNameModels : [String] = [""]
    public var deckName : [String] = [""]
    public var homePageVc = HomePageCollectionViewController()
    private var tableView = UITableView()
    public var deckId :String = ""
    public var cardId : [String] = []
    private let identifier = "detailCell"
    let notificationCenter = UNUserNotificationCenter.current()
    var datePicker = UIDatePicker()
    var reminderLabel = UILabel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        print("detailviewcontroller deckId \(deckId)")
        print("buraya bak detailView\(cardId)")
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if(!permissionGranted)
            {
                print("Permission Denied")
            }
        }
    }
    
    private func setupTableView() {
        configureTableView()
        setupCell()
        setTableViewDelegate()
        configureDataPicker()
        tableView.isScrollEnabled = false
    }
    
    private func configureDataPicker() {
        view.addSubview(datePicker)
        view.addSubview(reminderLabel)
        
        reminderLabel.textColor = UIColor.black
        reminderLabel.font = UIFont(name: "Poppins-Light", size: 15)
        reminderLabel.text = "Reminder"
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 10),
            
            reminderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reminderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 310),
        ])
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
    
        notificationCenter.getNotificationSettings { (settings) in
            
            DispatchQueue.main.async
            {
                let title = "WordRem"
                let message = "It's time to examine your words"
                let date = self.datePicker.date
                
                if(settings.authorizationStatus == .authorized)
                {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request) { (error) in
                        if(error != nil)
                        {
                            print("Error " + error.debugDescription)
                            return
                        }
                    }
                    let ac = UIAlertController(title: "Notification Scheduled", message: "At " + self.formattedDate(date: date), preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                    self.present(ac, animated: true)
                }
                else
                {
                    let ac = UIAlertController(title: "Enable Notifications?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Settings", style: .default)
                    { (_) in
                        guard let setttingsURL = URL(string: UIApplication.openSettingsURLString)
                        else
                        {
                            return
                        }
                        
                        if(UIApplication.shared.canOpenURL(setttingsURL))
                        {
                            UIApplication.shared.open(setttingsURL) { (_) in}
                        }
                    }
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in}))
                    self.present(ac, animated: true)
                }
            }
        }
        configureFirebaseData()

    }
    
    func formattedDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
    

    private func configureFirebaseData() {
        let cardNameModel  = CardNameModel(frontName: frontName, backName: backName, cardDescription: cardDescription)
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
            vc.deckId = self.deckId
            vc.cardId = self.cardId
            print("buraya bak firebase \(cardId)")
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
    func sendTextField(_ frontName: [String], _ backName: [String], _ cardDescription: [String], _ fetchedCardNameModels: [String], _ cardId : String) {
        let vc = CardViewController()
        vc.frontName = frontName
        vc.backName = backName
        vc.cardDescription = cardDescription
    }
}



