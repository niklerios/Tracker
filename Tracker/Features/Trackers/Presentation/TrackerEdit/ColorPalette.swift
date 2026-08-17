//
//  ColorPalette.swift
//  Tracker
//
//  Created by Nikler on 8/16/26.
//

import UIKit

enum ColorPalette {
    static let colors: [UIColor] = (1...18).compactMap {
        let colorName = "Color selection \($0)"

        guard let color = UIColor(named: colorName) else {
            assertionFailure("Color {\(colorName)} not found in Assets!")
            return nil
        }
        
        return color
    }
}
