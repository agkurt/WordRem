//
//  ReminderManager.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 22.12.2023.
//

import UIKit

class ReminderManager {
    static let shared = ReminderManager()

    private var allReminders: [Reminder] {
        didSet {
            saveReminders()
        }
    }

    private var dataSourceURL: URL

    private init() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let remindersPath = documentsPath.appendingPathComponent("reminders").appendingPathExtension("plist")
        dataSourceURL = remindersPath
        allReminders = []
        loadReminders()
    }

    // MARK: - Functions
    func getAllReminders() -> [Reminder] {
        return allReminders
    }

    func create(reminder: Reminder) {
        allReminders.insert(reminder, at: 0)
        if let dueDate = reminder.dueDate {
            NotificationProvider.scheduleNotification(title: reminder.title, date: dueDate, id: reminder.id)
        }
    }

    func setComplete(reminder: Reminder) {
        if let index = allReminders.firstIndex(where: { $0.id == reminder.id }) {
            allReminders[index].isCompleted.toggle()
        }
    }

    func delete(reminder: Reminder) {
        if let index = allReminders.firstIndex(where: { $0.id == reminder.id }) {
            allReminders.remove(at: index)
            NotificationProvider.cancelNotification(identifiers: reminder.id)
        }
    }

    private func saveReminders() {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allReminders)
            try data.write(to: dataSourceURL)
        } catch {
            print("Error saving reminders: \(error)")
        }
    }

     func loadReminders() {
        do {
            let data = try Data(contentsOf: dataSourceURL)
            let decoder = PropertyListDecoder()
            allReminders = try decoder.decode([Reminder].self, from: data)
        } catch {
            print("Error loading reminders: \(error)")
        }
    }
    
}
