//
//  NewDeckViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 17.10.2023.
//

import UIKit

protocol ImagePickerDelegate : AnyObject {
    func showImagePickerOptions(_ image : UIImage)
    func didTapSelectButton()
}


class NewDeckViewController : UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,ImagePickerDelegate   {
    
    func didTapSelectButton() {
        showImagePickerOptions()
    }
    

    func showImagePickerOptions(_ image: UIImage) {
        imageView.image = image
    }
    
    private var tableView = UITableView()
    private var newDeckView = NewDeckView()
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        self.view.addSubview(newDeckView)
        self.view.addSubview(tableView)
        self.view.addSubview(imageView)
        setTableViewDelegate()
        tableView.register(NewDeckTableViewCell.self, forCellReuseIdentifier: "deckCell")
        tableView.register(DeckColorTableViewCell.self, forCellReuseIdentifier: "colorCell")
        tableView.register(DeckImageTableViewCell.self, forCellReuseIdentifier: "deckImage")
        configureNavigationbar()
        newDeckView.pin(to: view)
        configureView()
        tableView.separatorStyle = .none
        title = "New Deck"
    }
    
    public func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
        
        public func showImagePickerOptions() {
            let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose a picture from Library or camera", preferredStyle: .actionSheet)

            let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in //Capture self to avoid retain cycles
                guard let self = self else {return}
                let cameraImagePicker = self.imagePicker (sourceType: .camera)
                cameraImagePicker.delegate = self
                self.present(cameraImagePicker, animated: true) {
                    //TODO
                }
            }

            let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in //Capture self to avoid retain cycles
                guard let self = self else {return}
                let libraryImagePicker = self.imagePicker (sourceType: .photoLibrary)
                libraryImagePicker.delegate = self
                self.present(libraryImagePicker, animated: true) {
                   
                }
            }
            let cancelAction = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(cameraAction)
            alertVC.addAction(libraryAction)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    
   
    @objc func doneButtonTapped() {
        print("agk")
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.systemGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        tableView.layer.shadowOpacity = 1.0
        tableView.layer.shadowRadius = 2
        tableView.layer.masksToBounds = true
        tableView.clipsToBounds = true
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor , constant: -140),
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        ])
        
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
    
}

extension NewDeckViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell  = tableView.dequeueReusableCell(withIdentifier: "deckCell") as? NewDeckTableViewCell else {
                fatalError("Wrong cell file")
            }
            return cell
        case 1:
            guard let cell  = tableView.dequeueReusableCell(withIdentifier: "deckCell") as? NewDeckTableViewCell else {
                fatalError("Wrong cell identifier")
            }
            return cell
        case 2:
            guard let cell  = tableView.dequeueReusableCell(withIdentifier: "colorCell") as? DeckColorTableViewCell else {
                fatalError("Wrong cell identifier")
                
            }
            return cell
        case 3:
            guard let cell  = tableView.dequeueReusableCell(withIdentifier: "deckImage") as? DeckImageTableViewCell else {
                fatalError("Wrong cell identifier")
            }
            return cell
        default :
            guard let cell  = tableView.dequeueReusableCell(withIdentifier: "colorCell") as? DeckColorTableViewCell else {
                fatalError("Wrong cell identifier")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 60
        case 1:
            return 60
        case 2:
            return 120
        case 3:
            return 200
        default:
            return 60
        }
        
    }
}

