//
//  UINavigationController+Extensions.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

extension UINavigationController {
    enum Style { case standard, custom }
    
    convenience init(root: UIViewController, withStyle style: Style = .standard) {
        self.init(rootViewController: root)
        
        if case .custom = style {
            let customColor: UIColor = .colorBlack
            
            navigationBar.prefersLargeTitles = true
            navigationBar.largeTitleTextAttributes = [.foregroundColor: customColor]
            navigationBar.tintColor = customColor
        }
    }
}
