//
//  DateHelper.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import Foundation

struct DateHelper {
    static let gregorianCalendar = Calendar(identifier: .gregorian)
    
    static let defaultFormatter = DateFormatter()
    
    static let daysTextFormatter = {
        $0.allowedUnits = [.day]
        $0.unitsStyle = .full
        
        return $0
    }(DateComponentsFormatter())
    
    static func startOfDay(_ date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
    
    static func getDaysText(days: Int) -> String? {
        daysTextFormatter.string(from: seconds(fromDays: days))
    }
    
    private static func seconds(fromDays days: Int) -> Double {
        Double(days * 24 * 60 * 60)
    }
}
