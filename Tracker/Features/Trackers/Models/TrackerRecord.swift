//
//  TrackerRecord.swift
//  Tracker
//
//  Created by Nikler on 7/25/26.
//

import Foundation

struct TrackerRecord: Hashable {
    let trackerId: UUID
    let completionDate: Date
}
