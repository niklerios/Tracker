//
//  ColorsHelper.swift
//  Tracker
//
//  Created by Nikler on 8/14/26.
//

import UIKit

struct ColorsHelper {
    static let colors: [UIColor] = [
        .colorSelection1,
        .colorSelection2,
        .colorSelection3,
        .colorSelection4,
        .colorSelection5,
        .colorSelection6,
        .colorSelection7,
        .colorSelection8,
        .colorSelection9,
        .colorSelection10,
        .colorSelection11,
        .colorSelection12,
        .colorSelection13,
        .colorSelection14,
        .colorSelection15,
        .colorSelection16,
        .colorSelection17,
        .colorSelection18
    ]
    
    static var randomColor: UIColor {
        colors[Int.random(in: (0..<colors.count))]
    }
}
