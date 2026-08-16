//
//  Date+Extensions.swift
//  Tracker
//
//  Created by Nikler on 8/16/26.
//

import Foundation

extension Date {
    private static let defaultFormatter = DateFormatter()
    
    private static let localizedDaysCountTextFormatter = {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.day]
        formatter.unitsStyle = .full
        
        return formatter
    }()
    
    static func localizedCountText(forDays count: Int) -> String? {
        localizedDaysCountTextFormatter.string(from: Double(count * 24 * 60 * 60))
    }
    
    static var weekdayItems: [String] {
        defaultFormatter.weekdaySymbols
    }
    
    static var shortWeekdayItems: [String] {
        defaultFormatter.shortWeekdaySymbols
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var dayNumber: Int {
        Calendar.gregorian.component(.weekday, from: self)
    }
}
