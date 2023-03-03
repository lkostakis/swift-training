//
//  CustomFormatter.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 2/3/23.
//

import Foundation

extension Date {
    var displayFormat: String {
        formatted(date: .numeric, time: .standard)
    }
}
