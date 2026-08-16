//
//  Weekday.swift
//  Tracker
//
//  Created by Nikler on 7/25/26.
//

import Foundation

enum Weekday: Int, CaseIterable {
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    case sunday = 1
    
    init(from date: Date) {
        self.init(rawValue: date.dayNumber)!
    }
    
    func toDayText(short: Bool = false) -> String {
        let index = rawValue - 1
        
        if (short) {
            return Calendar.shortWeekdayItems[safe: index]!
        } else {
            return Calendar.weekdayItems[safe: index]!
        }
    }
    
    static func weekdaysListToShortText(_ weekdays: [Self]) -> String {
        weekdays.map { $0.toDayText(short: true) }.joined(separator: ", ")
    }
}
