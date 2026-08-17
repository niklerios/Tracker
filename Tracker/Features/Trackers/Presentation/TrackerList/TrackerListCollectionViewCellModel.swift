//
//  TrackerListCollectionViewCellModel.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import UIKit

struct TrackerListCollectionViewCellModel {
    let title: String
    let emoji: Character
    let quantityText: String
    let checked: Bool
    let disabled: Bool
    let color: UIColor
    let tapHandler: () -> Void
    
    static func quantityText(from quantity: Int) -> String {
        Calendar.localizedCountText(forDays: quantity) ?? ""
    }
}

extension TrackerListCollectionViewCellModel {
    init(
        tracker: Tracker,
        quantity: Int,
        checked: Bool,
        disabled: Bool,
        tapHandler: @escaping () -> Void
    ) {
        self.init(
            title: tracker.title,
            emoji: tracker.emoji,
            quantityText: Self.quantityText(from: quantity),
            checked: checked,
            disabled: disabled,
            color: tracker.color,
            tapHandler: tapHandler
        )
    }
}
