//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Ali Mert Özhayta on 16.04.2022.
//

import SwiftUI

// MARK: - Color

extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

// MARK: - Date Formatter

extension DateFormatter {

    static var allNumeric: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }
}

// MARK: - String

extension String {

    func parseToDate() -> Date? {
        DateFormatter.allNumeric.date(from: self)
    }
}

// MARK: - Date

extension Date: Strideable {

    func formatted() -> String {
        self.formatted(.dateTime.year().month().day())
    }
}

// MARK: - Double

extension Double {

    func roundedTo2Digits() -> Double {
        (self * 100).rounded() / 100
    }
}
