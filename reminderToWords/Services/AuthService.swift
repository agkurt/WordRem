//
//  AuthService.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 7.11.2023.


import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    public static let shared = AuthService()
    var vc = CardViewController()
    var deckId : [String] = []
    public func registerUser(with userRequest:RegisterUserRequest, completion : @escaping (Bool,Error?) -> Void) {
        let username = userRequest.username ?? ""
        let password = userRequest.password ?? ""
        let email = userRequest.email ?? ""
        
        Auth.auth().createUser(withEmail: email, password: password) {result , error in // Firebase authentication SDK
            if let error = error {
                completion(false , error)
                return
                
            }
            guard let resultUser = result?.user else {
                completion(false , nil)
                return
            }
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email,
                    "password": password
                ]) { error in
                    if let error = error {
                        completion(false , error)
                        return
                    }
                    completion(true , nil)
                }
        }
    }
    
    public func userLogin(with userRequest : LoginUserRequest , completion : @escaping (Bool? , Error?) -> Void) {
        let email = userRequest.email ?? ""
        let password = userRequest.password ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) {
            result , error in
            if let error = error {
                completion(nil, error)
                return
            }else {
                completion(nil, nil)
            }
            
        }
    }
    
    public func signOut(completion : @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        }catch let error {
            completion(error)
        }
    }
    
    public func forgotPassword(with email : String , completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    public func addDataToFirebase(_ dataModel :DataModel , completion : @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "AuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Current user not found."]))
            return
        }
        
        let db = Firestore.firestore()
        let data : [String:Any] = ["deckName": dataModel.deckName]
        
        db.collection("users").document(uid).collection("decks")
            .addDocument(data: data){ error in
                completion(error)
            }
        
    }
    
    public func addCardNameDataToFirebase(_ cardNameDataModel: CardNameModel, deckId: String, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "AuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Current user not found."]))
            return
        }
        
        let db = Firestore.firestore()
        let data : [String:Any] = ["frontName": cardNameDataModel.frontName,
                                   "backName":cardNameDataModel.backName,
                                   "cardDescription":cardNameDataModel.cardDescription,
                                   ]
        
        db.collection("users").document(uid).collection("decks").document(deckId).collection("cardName")
            .addDocument(data: data) { error in
                completion(error)
            }
    }
    public func fetchCurrentUserDecksData(completion: @escaping ([String]?, [String]?, Error?) -> Void) {
            guard let currentUserUID = Auth.auth().currentUser?.uid else {
                completion(nil, nil, NSError(domain: "AuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User is not logged in"]))
                return
            }
            
            let db = Firestore.firestore()
            let userDecksRef = db.collection("users").document(currentUserUID).collection("decks")
            
            userDecksRef.getDocuments { (snapshot, error) in
                if let error = error {
                    completion(nil, nil, error)
                    return
                }
                
                var fetchedDeckNames = [String]()
                var deckIds = [String]()
                
                for document in snapshot?.documents ?? [] {
                    let deckData = document.data()
                    if let deckNameArray = deckData["deckName"] as? [String] {
                        for deckName in deckNameArray {
                            fetchedDeckNames.append(deckName)
                            deckIds.append(document.documentID)
                            print("authservice deckIds:\(deckIds)")
                        }
                    }
                }
                
                completion(fetchedDeckNames, deckIds, nil)
            }
        }
    
    public func fetchCurrentUserCardsData(deckId: String, completion: @escaping ([String]?, [String]?, [String]?,[String]?, Error?) -> Void) {
           guard let currentUserUID = Auth.auth().currentUser?.uid else {
               completion(nil, nil, nil, nil, NSError(domain: "AuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User is not logged in"]))
               return
           }
           
           let db = Firestore.firestore()
           let userDecksRef = db.collection("users").document(currentUserUID).collection("decks").document(deckId).collection("cardName")
           
           userDecksRef.getDocuments { (snapshot, error) in
               if let error = error {
                   completion(nil, nil, nil,nil , error)
                   return
               }
               
               var cardIds = [String]()
               var frontNames = [String]()
               var backNames = [String]()
               var cardDescriptions = [String]()
               
               
               for document in snapshot?.documents ?? [] {
                   let deckData = document.data()
                   if let frontNameArray = deckData["frontName"] as? [String],
                      let backNameArray = deckData["backName"] as? [String],
                      let cardDescriptionArray = deckData["cardDescription"] as? [String] {
                       
                       frontNames.append(contentsOf: frontNameArray)
                       backNames.append(contentsOf: backNameArray)
                       cardDescriptions.append(contentsOf: cardDescriptionArray)
                       cardIds.append(document.documentID)
                       print("authservice cardIds \(cardIds)")
                       
                   }
               }
               
               completion(frontNames, backNames, cardDescriptions, cardIds ,nil)
           }
       }
    
    func deleteCardFromFirebase(cardID: String, deckId: String, completion: @escaping (Error?) -> Void) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "AuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User is not logged in"]))
            return
        }
        
        let db = Firestore.firestore()
        let userCardRef = db.collection("users").document(currentUserUID).collection("decks").document(deckId).collection("cardName").document(cardID)
        
        userCardRef.delete { error in
            if let error = error {
                // Firestore'dan dönen hata yakalanıyor
                print("Firestore Error: \(error.localizedDescription)")
                completion(error) // Hatanın tamamını geri dön
                return
            }
            completion(nil) // Hata yok, silme başarılı
        }
    }

}
