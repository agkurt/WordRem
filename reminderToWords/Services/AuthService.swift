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
    // comand + option + questionMark
    /// A method to register user
    /// - Parameters:
    ///   - userRequest: the user information
    ///   - completion: A completion with two values ...
    ///   - Bool : wasRegistered -determines if the user was registered and save in the database correctly
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
            // -MARK
            // check bool
            if let error = error {
                completion(nil, error)
                return
            }else {
                completion(nil, nil)
            }
        
        }
    }
    /// SignOut for firebase
    /// - Parameter completion: completion description
    /// - Do : hata olma olasılığı için
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

}




