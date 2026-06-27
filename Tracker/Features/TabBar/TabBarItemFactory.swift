//
//  TabBarItemFactory.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

enum TabBarItemFactory {
    static func trackers() -> UITabBarItem {
        UITabBarItem(
            title: "Трекеры",
            image: .trackers,
            selectedImage: .trackers,
        )
    }
    
    static func statistics() -> UITabBarItem {
        UITabBarItem(
            title: "Статистика",
            image: .statistics,
            selectedImage: .statistics
        )
    }
}
