//
//  CardNameModel.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 23.11.2023.
//

import Foundation

struct CardNameModel :Decodable {
    let frontName : [String?]
    let backName : [String?]
    let cardDescription: [String?]
    let cardId : String
}
