//
//  DateHelper.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import Foundation

struct DateHelper {
    static let gregorianCalendar = Calendar(identifier: .gregorian)
    
    // @todo - убрать и использовать дефолтный ,когда появится локализация
    private static let ruCalendar = {
        var calendar = Calendar(identifier: .gregorian)

        calendar.locale = Locale(identifier: "ru_RU")
        
        return calendar
    }()
    
    static let daysTextFormatter = {
        $0.allowedUnits = [.day]
        $0.unitsStyle = .full
        // @todo - убрать и использовать дефолтный ,когда появится локализация
        $0.calendar = ruCalendar
        
        return $0
    }(DateComponentsFormatter())
    
    static func startOfDay(_ date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
    
    static func getDaysText(days: Int) -> String? {
        let seconds = Double(days * 24 * 60 * 60)
        
        return daysTextFormatter.string(from: seconds)
    }
}
