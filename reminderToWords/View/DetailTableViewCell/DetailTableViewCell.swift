//
//  DetailTableViewCell.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 27.10.2023.
//

import UIKit

class DetailTableViewCell: UITableViewCell, UITextFieldDelegate {
        
    private let frontLabel = UIComponentsHelper.createCustomLabel(text: "Card Front", size: 15, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-Light")
    private let backLabel = UIComponentsHelper.createCustomLabel(text: "Card Back", size: 15, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-Light")
    private let descriptionLabel = UIComponentsHelper.createCustomLabel(text: "Card Description", size: 15, labelBackGroundColor: .clear, textColor: UIColor.black, fontName: "Poppins-Light")
    public let frontTextField = UIComponentsHelper.createTextField(placeholder: "Front card", textColor: UIColor.black, backgroundColor: UIColor.clear)
    public let backTextField = UIComponentsHelper.createTextField(placeholder: "Back card", textColor: UIColor.black, backgroundColor: UIColor.clear)
    public let cardDescription = UIComponentsHelper.createTextField(placeholder: "Description", textColor: UIColor.black, backgroundColor: UIColor.clear)
    
    lazy var switchButton : UISwitch = {
        let switchButton = UISwitch()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        // Switch button değiştiğinde çağrılacak fonksiyonu belirle
        switchButton.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return switchButton
    }()
    
    lazy var datePicker : UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        // DatePicker'in tarih modunu seç
        datePicker.datePickerMode = .dateAndTime
        // DatePicker'in başlangıç tarihini belirle
        datePicker.date = Date()
        // DatePicker'in görünürlüğünü başlangıçta kapalı yap
        datePicker.isHidden = true
        return datePicker
    }()
    
    public var fetchedCardNameModels : [String] = []
    
    weak var delegate :SendTextFieldDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableViewCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupTableViewCell() {
        setupUI()
        configureUI()
    }
    
    public func configureCell(delegate : SendTextFieldDelegate , frontText: String,tag :Int, backText: String, descriptionText: String) {
        
        frontTextField.text = frontText
        backTextField.text = backText
        cardDescription.text = descriptionText
        
        frontTextField.tag = tag
        backTextField.tag = tag
        cardDescription.tag = tag
        
        frontTextField.delegate = delegate as? UITextFieldDelegate
        backTextField.delegate = delegate as? UITextFieldDelegate
        cardDescription.delegate = delegate as? UITextFieldDelegate
        

    }
    @objc func switchChanged(_ sender: UISwitch) {
        // Switch button açıksa
        if sender.isOn {
            // DatePicker'i göster
            datePicker.isHidden = false
            // DatePicker'den seçilen tarihi al
            let date = datePicker.date
            // Tarihin geçmişte olmadığını kontrol et
            if date > Date() {
                // Bir reminder oluştur
                let reminder = Reminder(id: UUID().uuidString, title: "Test", dueDate: date, frontName: frontTextField.text ?? "") // Bu satırı değiştirdim
                // ReminderManager ile kaydet
                ReminderManager.shared.create(reminder: reminder)
            } else {
                // Hata mesajı göster
                print("Tarih geçmişte olamaz")
            }
        } else {
            // Switch button kapalıysa
            // DatePicker'i gizle
            datePicker.isHidden = true
        }
    }


    
    private func setupUI() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(frontLabel)
        contentView.addSubview(backLabel)
        contentView.addSubview(frontTextField)
        contentView.addSubview(backTextField)
        contentView.addSubview(cardDescription)
        contentView.addSubview(switchButton)
        contentView.addSubview(datePicker)
    }
    
    private func configureUI() {
        frontLabel.anchor(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        backLabel.anchor(top: frontTextField.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        descriptionLabel.anchor(top: backTextField.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        frontTextField.anchor(top: frontLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        backTextField.anchor(top: backLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left:leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        cardDescription.anchor(top: descriptionLabel.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 50, centerXAnchor: centerXAnchor, centerYAnchor: nil)
        
        switchButton.anchor(top: cardDescription.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        
        datePicker.anchor(top: switchButton.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0, centerXAnchor: nil, centerYAnchor: nil)
        
        
        
        
        
        frontTextField.layer.borderWidth = 1.0
        frontTextField.layer.borderColor = UIColor.gray.cgColor
        frontTextField.layer.cornerRadius = 10
        
        backTextField.layer.borderWidth = 1.0
        backTextField.layer.borderColor = UIColor.gray.cgColor
        backTextField.layer.cornerRadius = 10
        
        cardDescription.layer.borderWidth = 1.0
        cardDescription.layer.borderColor = UIColor.gray.cgColor
        cardDescription.layer.cornerRadius = 10

    }
}
