//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

final class TrackersViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let collectionDataManager = TrackersDataManager()
    private let collectionViewDelegate = TrackersCollectionViewDelegate()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        collectionDataManager.delegate = self
        
        tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: .trackers,
            selectedImage: .trackers,
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = TrackersView(
            collectionDelegate: collectionViewDelegate,
            collectionDataSource: collectionDataManager
        )
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
        collectionDataManager.setSelectedDate(sender.date)
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchResultsUpdater = collectionDataManager
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupNavigationBar() {
        title = "Трекеры"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .addTracker,
            style: .plain,
            target: self,
            action: #selector(didTapAddButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: createDatePicker()
        )
    }
    
    private func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(
            self,
            action: #selector(didChangeSelectedDate),
            for: .valueChanged
        )
        
        return datePicker
    }
}

// MARK: - TrackersCollectionDataManagerDelegate

extension TrackersViewController: TrackersCollectionDataManagerDelegate {
    func visibleCategoriesDidUpdate() {
        (view as? TrackersView)?.reloadData()
    }
}
