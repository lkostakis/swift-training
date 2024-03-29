//
//  Settings.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 2/3/23.
//

import Foundation

class Settings {
    static let shared: Settings = {
        let instance = Settings()
        instance.startListeningWhenDifficultyLevelChanged()
        return instance
    }()
    var currentLevel: DifficultyLevel = .heyNotTooRough
    private init() {}

    enum DifficultyLevel: Int, CaseIterable, Codable {
        var description: String {
            toString()
        }

        case tooYoungToDie = 30, heyNotTooRough = 100, hurtMePlenty = 200, ultraViolence = 300, nightmare = 1000

        // helping function to get string based on case
        func toString() -> String {
            switch self {
            case .tooYoungToDie: return "I'm too young to die (1-30)"
            case .heyNotTooRough: return "Hey, not too rough (1-100)"
            case .hurtMePlenty: return "Hurt me plenty (1-200)"
            case .ultraViolence: return "Ultra-Violence (1-300)"
            case .nightmare: return "Nightmare! (1-1000)"
            }
        }
    }
}

extension Settings {
    private final func startListeningWhenDifficultyLevelChanged() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSelectedLevel(notification:)),
                                               name: NSNotification.Name.DifficultyLevelChanged,
                                               object: nil)
    }

    @objc func changeSelectedLevel(notification: Notification) {
        if let level = notification.userInfo?["level_changed"] as? Settings.DifficultyLevel {
            Settings.shared.currentLevel = level
        }
    }
}
