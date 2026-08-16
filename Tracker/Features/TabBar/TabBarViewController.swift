//
//  TabBarViewController.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            UINavigationController(root: TrackersViewController(), withStyle: .custom),
            StatisticsViewController(),
        ]
    }
    
    private func setupUI() {
        let appearance = UITabBarAppearance()
        let layoutAppearance = appearance.stackedLayoutAppearance
        
        appearance.configureWithOpaqueBackground()
        
        setupItemStateAppearance(layoutAppearance.normal, color: .colorGray)
        setupItemStateAppearance(layoutAppearance.selected, color: .colorBlue)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupItemStateAppearance(
        _ appearance: UITabBarItemStateAppearance,
        color: UIColor
    ) {
        appearance.iconColor = color
        appearance.titleTextAttributes = [.foregroundColor: color]
    }
}
