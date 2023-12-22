//
//  LocalNotificationManager.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 20.12.2023.
//

import Foundation
import UIKit
import UserNotifications

class NotificationProvider {
    static func scheduleNotification(title: String, date: Date, id: String) { // Bu satırı değiştirin
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                createNotification(title: title, date: date, id: id) // Bu satırı değiştirin
            } else {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge,.sound]) { success,error  in
                    if success {
                        createNotification(title: title, date: date, id: id) // Bu satırı değiştirin
                    }
                }
            }
        }
    }

    static func cancelNotification( identifiers: String) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifiers])
    }
    

    static func createNotification(title: String, date: Date, id: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
