//
//  Weekday.swift
//  Tracker
//
//  Created by Nikler on 7/25/26.
//

import Foundation

enum Weekday: Int, CaseIterable {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    init(from date: Date) {
        // При использовании григорианского календаря гарантируем что rawValue будет в диапазоне [1..7]
        self.init(rawValue: DateHelper.gregorianCalendar.component(.weekday, from: date))!
    }
}
