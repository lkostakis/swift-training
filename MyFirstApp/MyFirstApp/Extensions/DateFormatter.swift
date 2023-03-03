//
//  DateFormatter.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 2/3/23.
//

import Foundation

extension DateFormatter {
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }()
}
