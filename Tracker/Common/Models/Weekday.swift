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
    
    private var defaultDayText: String {
        switch self {
        case .monday: "monday"
        case .tuesday: "tuesday"
        case .wednesday: "wednesday"
        case .thursday: "thursday"
        case .friday: "friday"
        case .saturday: "saturday"
        case .sunday: "sunday"
        }
    }
    
    private var defaultShortDayText: String {
        switch self {
        case .monday: "mon"
        case .tuesday: "tue"
        case .wednesday: "wed"
        case .thursday: "thu"
        case .friday: "fri"
        case .saturday: "sat"
        case .sunday: "sun"
        }
    }
    
    init(from date: Date) {
        // При использовании григорианского календаря гарантируем что rawValue будет в диапазоне [1..7]
        self.init(rawValue: DateHelper.gregorianCalendar.component(.weekday, from: date))!
    }
    
    func toDayText(short: Bool = false) -> String {
        let formatter = DateHelper.defaultFormatter
        let index = rawValue - 1
        
        if (short) {
            return formatter.shortWeekdaySymbols[
                safe: index,
                default: self.defaultShortDayText
            ]
        } else {
            return formatter.weekdaySymbols[
                safe: index,
                default: self.defaultDayText
            ]
        }
    }
    
    static func weekdaysListToShortText(_ weekdays: [Self]) -> String {
        weekdays.map { $0.toDayText(short: true) }.joined(separator: ", ")
    }
}
