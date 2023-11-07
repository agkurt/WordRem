//
//  AuthService.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 7.11.2023.


import UIKit
import FirebaseAuth

class AuthService {
    
    public static let shared = AuthService()
    
    private func registerUser(with userRequest:RegisterUserRequest, completion : @escaping (Bool,Error) -> Void) {
        let username = userRequest.username
        let password = userRequest.password
        let email = userRequest.email
        
    }
}




