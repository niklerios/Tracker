//
//  TrackersCollectionViewCellViewModel.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import UIKit

struct TrackersCollectionViewCellViewModel {
    let title: String
    let emoji: Character
    let quantityText: String
    let checked: Bool
    let color: UIColor
    let tapHandler: () -> Void
    
    static func getQuantityText(_ quantity: Int) -> String {
        "\(quantity) дней"
    }
}

extension TrackersCollectionViewCellViewModel {
    init(
        tracker: Tracker,
        quantity: Int,
        checked: Bool,
        tapHandler: @escaping () -> Void
    ) {
        self.init(
            title: tracker.title,
            emoji: tracker.emoji,
            quantityText: Self.getQuantityText(quantity),
            checked: checked,
            color: tracker.color,
            tapHandler: tapHandler
        )
    }
}
