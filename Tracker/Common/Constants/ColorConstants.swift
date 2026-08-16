//
//  ColorConstants.swift
//  Tracker
//
//  Created by Nikler on 8/16/26.
//

import UIKit

struct ColorConstants {
    static let colors: [UIColor] = (1...18).compactMap {
        UIColor(named: "Color selection \($0)")
    }
}
