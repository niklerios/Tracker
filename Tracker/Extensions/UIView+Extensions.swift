//
//  UIView+Extensions.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    func autoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
