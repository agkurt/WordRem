//
//  File.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 22.12.2023.
//

import UIKit

enum Theme: String {
    case light, dark, system

    // Utility var to pass directly to window.overrideUserInterfaceStyle
    var uiInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .unspecified
        }
    }
}
