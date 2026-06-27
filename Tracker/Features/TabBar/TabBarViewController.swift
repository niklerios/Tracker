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
        
        configureTabBar()
        configureViewControllers()
    }
    
    private func configureViewControllers() {
        let trackers = TrackersFactory.makeViewControllerWithNavigation()
        let statistics = StatisticsFactory.makeViewController()
        
        trackers.tabBarItem = TabBarItemFactory.trackers()
        trackers.tabBarItem = TabBarItemFactory.statistics()
        
        viewControllers = [
            trackers,
            trackers,
        ]
    }
    
    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        let layoutAppearance = appearance.stackedLayoutAppearance
        
        appearance.configureWithOpaqueBackground()
        
        configureTabBarItemStateAppearance(layoutAppearance.normal, color: .colorGray)
        configureTabBarItemStateAppearance(layoutAppearance.selected, color: .colorBlue)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func configureTabBarItemStateAppearance(
        _ appearance: UITabBarItemStateAppearance,
        color: UIColor
    ) {
        appearance.iconColor = color
        appearance.titleTextAttributes = [.foregroundColor: color]
    }
}
