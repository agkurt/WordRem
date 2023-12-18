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
                                   "cardId": cardNameDataModel.cardId]
        
        db.collection("users").document(uid).collection("decks").document(deckId).collection("cardName")
            .addDocument(data: data) { error in
                completion(error)
            }
    }
}
