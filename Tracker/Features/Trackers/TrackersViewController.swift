//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

final class TrackersViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var categories: [TrackerCategory] = []
    private var completedTrackers: [TrackerRecord] = []
    
    override func loadView() {
        view = TrackersView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupSearchController()
    }
    
    @objc private func didTapAddButton() {
        print(#function)
    }
    
    @objc private func didChangeSelectedDate(_ sender: UIDatePicker) {
        print(sender.date)
    }
}

// MARK: - Implement UISearchResultsUpdating
extension TrackersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }

        print(searchText)
    }
}

// MARK: - Setup SearchController
extension TrackersViewController {
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
    }
}

// MARK: - Setup NavigationBar
extension TrackersViewController {
    private func setupNavigationBar() {
        setupNavigationBarTitle()
        setupNavigationBarAddButton()
        setupNavigationBarDateLabel()
    }
    
    private func setupNavigationBarTitle() {
        title = "Трекеры"
    }
    
    private func setupNavigationBarAddButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .addTracker,
            style: .plain,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    private func setupNavigationBarDateLabel() {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(
            self,
            action: #selector(didChangeSelectedDate),
            for: .valueChanged
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: datePicker
        )
    }
}
