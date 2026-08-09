//
//  StatisticsViewController.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

final class StatisticsViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        tabBarItem = UITabBarItem(
            title: "Статистика",
            image: .statistics,
            selectedImage: .statistics
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .colorWhite
    }
}
