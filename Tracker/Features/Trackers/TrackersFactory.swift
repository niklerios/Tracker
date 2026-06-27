//
//  TrackersFactory.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

enum TrackersFactory {
    static func makeViewController() -> TrackersViewController {
        TrackersViewController()
    }
    
    static func makeViewControllerWithNavigation() -> UINavigationController {
        UINavigationController(root: makeViewController()).withStyle(.standard)
    }
}
