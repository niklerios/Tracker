//
//  TrackerCollectionContsants.swift
//  Tracker
//
//  Created by Nikler on 8/9/26.
//

import UIKit

struct TrackerCollectionContsants {
    static let edgeInsets = UIEdgeInsets(
        top: 12,
        left: 16,
        bottom: 16,
        right: 16
    )
    
    // Вычел 8 пунктов от высоты из Figma (тк добавил их в составе minimumLineSpacing)
    static let cellHeight: CGFloat = 140
    static let cellSpacing: CGFloat = 8
    static let cellsCount = 2
    
    static let paddingWidth: CGFloat = {
        edgeInsets.left + edgeInsets.right + CGFloat(cellsCount - 1) * cellSpacing
    }()
}
