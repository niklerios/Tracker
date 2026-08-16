//
//  UIStackView+Extensions.swift
//  Tracker
//
//  Created by Nikler on 7/4/26.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
}
