//
//  Tracker.swift
//  Tracker
//
//  Created by Nikler on 7/25/26.
//

import UIKit

struct Tracker {
    let id: UUID
    let title: String
    let color: UIColor
    let emoji: Character
    let schedule: [Weekday]
}
