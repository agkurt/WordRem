//
//  Ext + CardViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 12.12.2023.
//

import UIKit
import Firebase
import FirebaseAuth

extension CardViewController: UITableViewDelegate , UITableViewDataSource,SendTextFieldDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Silinecek veriyi geçici değişkenlere kaydet
            let deletedFrontName = frontName[indexPath.row]
            let deletedBackName = backName[indexPath.row]
            let deletedCardDescription = cardDescription[indexPath.row]
            
            // Firestore'dan silinen veriyi 'deletedItems' koleksiyonuna ekle
            let db = Firestore.firestore()
            let currentUserUID = Auth.auth().currentUser?.uid ?? ""
            let deletedItemsRef = db.collection("users").document(currentUserUID).collection("decks").document(deckId).collection("deletedItems")
            
            deletedItemsRef.addDocument(data: [
                "frontName": deletedFrontName,
                "backName": deletedBackName,
                "cardDescription": deletedCardDescription,
                "deletedAt": FieldValue.serverTimestamp() // Opsiyonel: Silinme zamanını eklemek için
            ]) { err in
                if let err = err {
                    print("Error adding document to deletedItems: \(err)")
                } else {
                    print("Document added successfully to deletedItems")
                }
            }
            
            // TableView'dan hücreyi sil
            frontName.remove(at: indexPath.row)
            backName.remove(at: indexPath.row)
            cardDescription.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frontName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as? CardTableViewCell else {
            fatalError("wrong identifier")
        }
        cell.configure(frontName[indexPath.row],backName[indexPath.row],cardDescription[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.word.text = frontName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CardTableViewCell
        cell.toggleReminder()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // Silmeye izin ver
    }
    
    func sendTextField(_ frontName: [String], _ backName: [String], _ cardDescription: [String], _ fetchedCardNameModels: [String]) {
        self.frontName = frontName
        self.backName = backName
        self.cardDescription = cardDescription
    }
    
}
