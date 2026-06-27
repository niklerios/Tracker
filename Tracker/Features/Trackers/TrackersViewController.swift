//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

final class TrackersViewController: UIViewController {
    private var trackers = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureNavigationBar()
    }
    
    @objc private func didTapAddButton() {
        print(#function)
    }
    
    private func setupView() {
        view = TrackersView()
    }
}

// MARK: - NavigationBar
extension TrackersViewController {
    private func configureNavigationBar() {
        configureNavigationBarTitle()
        configureNavigationBarAddButton()
        configureNavigationBarDateLabel()
    }
    
    private func configureNavigationBarTitle() {
        title = "Трекеры"
    }
    
    private func configureNavigationBarAddButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .addTracker,
            style: .plain,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    private func configureNavigationBarDateLabel() {
        
    }
}
