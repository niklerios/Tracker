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
            let customTextColor: UIColor = .colorBlack
            let appearance = UINavigationBarAppearance()
            
            appearance.configureWithOpaqueBackground()
            appearance.largeTitleTextAttributes = [.foregroundColor: customTextColor]
            appearance.titleTextAttributes = [.foregroundColor: customTextColor]
            appearance.shadowColor = .clear
            
            navigationBar.prefersLargeTitles = true
            navigationBar.tintColor = customTextColor

            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
        }
    }
}
