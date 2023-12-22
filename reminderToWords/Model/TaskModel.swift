//
//  TaskModel.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 22.12.2023.
//

import Foundation

struct Reminder: Codable {
    var id = UUID().uuidString
    var title: String
    var dueDate: Date?
    var isCompleted: Bool = false
    var frontName :String
}
