//
//  TrackersDataMock.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import Foundation

struct TrackersDataMock {
    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    
    static let example = TrackersDataMock()
    
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
            emoji: "🚬",
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
        
        categories = [
            TrackerCategory(
                title: "Обычные дела",
                trackers: [
                    everydayTracker,
                    modayTracker,
                    evenDaysTracker,
                    oddDaysTracker,
                    weekendTracker
                ]
            ),
            TrackerCategory(
                title: "Спортик",
                trackers: [gymTracker]
            )
        ]
        
        completedTrackers = []
    }
}
