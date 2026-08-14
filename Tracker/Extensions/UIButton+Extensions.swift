//
//  UIButton+Extensions.swift
//  Tracker
//
//  Created by Nikler on 8/14/26.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(color.toImage(), for: state)
    }
}
