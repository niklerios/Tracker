//
//  Calendar+Extensions.swift
//  Tracker
//
//  Created by Nikler on 8/16/26.
//

import Foundation

extension Calendar {
    static let gregorian = Self.init(identifier: .gregorian)
    
    static func localizedCountText(forDays count: Int) -> String? {
        localizedDaysCountTextFormatter.string(from: Double(count * 24 * 60 * 60))
    }
    
    static var weekdayItems: [String] {
        formatter.weekdaySymbols
    }
    
    static var shortWeekdayItems: [String] {
        formatter.shortWeekdaySymbols
    }
}

extension Calendar {
    private static let formatter = DateFormatter()
    
    private static let localizedDaysCountTextFormatter = {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.day]
        formatter.unitsStyle = .full
        
        return formatter
    }()
}
