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
        
        if case .custom = style {
            setupCustomStyle()
        }
        
        if case .customModal = style {
            setupCustomModalStyle()
        }
    }
    
    private func setupCustomStyle() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.colorBlack]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.colorBlack]
        appearance.shadowColor = .clear
        
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = .colorBlack

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
    
    private func setupCustomModalStyle() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.colorBlack,
            .font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
}
