//
//  UINavigationController+Extensions.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

extension UINavigationController {
    enum Style { case standard, custom, customModal }
    
    convenience init(root: UIViewController, withStyle style: Style = .standard) {
        self.init(rootViewController: root)
        
        let customTextColor: UIColor = .colorBlack
        
        if case .custom = style {
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
        
        if case .customModal = style {
            let appearance = UINavigationBarAppearance()
            
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [
                .foregroundColor: customTextColor,
                .font: UIFont.systemFont(ofSize: 16, weight: .medium)
            ]
            appearance.shadowColor = .clear
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
        }
    }
}
