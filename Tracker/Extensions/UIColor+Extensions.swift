//
//  UIColor+Extensions.swift
//  Tracker
//
//  Created by Nikler on 8/14/26.
//

import UIKit

extension UIColor {
    func toImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))

        return renderer.image { context in
            self.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
    }
}
