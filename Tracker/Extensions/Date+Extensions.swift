//
//  Date+Extensions.swift
//  Tracker
//
//  Created by Nikler on 8/16/26.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var dayNumber: Int {
        Calendar.gregorian.component(.weekday, from: self)
    }
}
