//
//  Notification.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 10/3/23.
//

import Foundation

extension NSNotification.Name {
  static let HighScoreListChanged = NSNotification.Name(rawValue: "highscore_changed")
}

extension NSNotification.Name {
  static let DifficultyLevelChanged = NSNotification.Name(rawValue: "level_changed")
}
