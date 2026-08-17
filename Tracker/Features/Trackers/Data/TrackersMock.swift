//
//  TrackersMock.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import Foundation

struct TrackersMock {
    var categories: [TrackerCategory] = []
    var completedTrackers: Set<TrackerRecord> = []
    
    static let example = TrackersMock()
    static let defaultCategory = "Обычные дела"
    
    init() {
        let everydayTracker = Tracker(
            id: UUID(),
            title: "Выпивать 2л воды",
            color: .colorSelection3,
            emoji: "💧",
            schedule: Weekday.allCases
        )
        let modayTracker = Tracker(
            id: UUID(),
            title: "Составить план на неделю",
            color: .colorSelection13,
            emoji: "✅",
            schedule: [.monday]
        )
        let evenDaysTracker = Tracker(
            id: UUID(),
            title: "Пить витамины",
            color: .colorSelection1,
            emoji: "💊",
            schedule: [.tuesday, .thursday, .saturday]
        )
        let oddDaysTracker = Tracker(
            id: UUID(),
            title: "Шпыхать кальянчик",
            color: .colorSelection1,
            emoji: "💨",
            schedule: [.monday, .wednesday, .friday, .sunday]
        )
        let weekendTracker = Tracker(
            id: UUID(),
            title: "Поехать на дачу",
            color: .colorSelection10,
            emoji: "🏠",
            schedule: [.saturday, .sunday]
        )
        let gymTracker = Tracker(
            id: UUID(),
            title: "Ходить в качалку и жать сотку",
            color: .colorSelection12,
            emoji: "💪",
            schedule: [.monday, .wednesday, .friday, .sunday]
        )
        
        let commonCategory = TrackerCategory(
            title: Self.defaultCategory,
            trackers: [
                everydayTracker,
                modayTracker,
                evenDaysTracker,
                oddDaysTracker,
                weekendTracker
            ]
        )
        
        let sportCategory = TrackerCategory(
            title: "Спортик",
            trackers: [gymTracker]
        )
        
        categories = [commonCategory, sportCategory]
        
        completedTrackers = [
            TrackerRecord(
                trackerId: everydayTracker.id,
                completionDate: Date().startOfDay
            ),
            TrackerRecord(
                trackerId: modayTracker.id,
                completionDate: Date().startOfDay
            ),
            TrackerRecord(
                trackerId: evenDaysTracker.id,
                completionDate: Date().startOfDay
            ),
            TrackerRecord(
                trackerId: oddDaysTracker.id,
                completionDate: Date().startOfDay
            ),
            TrackerRecord(
                trackerId: weekendTracker.id,
                completionDate: Date().startOfDay
            ),
            TrackerRecord(
                trackerId: gymTracker.id,
                completionDate: Date().startOfDay
            ),
        ]
    }
}
