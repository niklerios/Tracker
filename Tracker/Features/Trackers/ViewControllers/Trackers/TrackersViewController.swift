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
        setupSearchController()    }
    
    @objc private func didTapAddButton() {
        let trackerEditController = TrackerEditViewController(tracker: nil) { [weak self] in
            self?.collectionDataManager.createTracker($0, forCategory: $1)
        }

        let navigationController = UINavigationController(
            root: trackerEditController,
            withStyle: .customModal
        )

        present(navigationController, animated: true)
    }
    
    @objc private func didChangeSelectedDate(_ sender: UIDatePicker) {
        let selectedDate = sender.date.startOfDay
        
        dismiss(animated: false)
        collectionDataManager.setSelectedDate(selectedDate)
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchResultsUpdater = collectionDataManager
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
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
    func trackerDidAddToVisibleCategory(section: Int, row: Int, numberOfSections: Int) {
        (view as? TrackersView)?.insertRowToCollectionView(
            indexPath: IndexPath(row: row, section: section),
            numberOfSections: numberOfSections
        )
    }
    
    func visibleCategoriesDidUpdate() {
        (view as? TrackersView)?.reloadCollectionViewData()
    }
}
