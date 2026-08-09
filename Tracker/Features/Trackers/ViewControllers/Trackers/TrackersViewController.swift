//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

let tracker = Tracker(
    id: UUID(),
    title: "Учить iOS и Swift",
    color: .blue,
    emoji: "😀",
    schedule: [.monday, .sunday, .friday]
)

let testCategories = [
    TrackerCategory(
        title: "Test Category",
        trackers: [
            tracker,
            tracker,
            tracker,
            tracker,
            tracker,
            tracker,
            tracker,
            tracker,
            tracker
        ]
    ),
    TrackerCategory(
        title: "Another Category",
        trackers: [tracker, tracker, tracker]
    )
]

final class TrackersViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var categories: [TrackerCategory] = testCategories
    private var completedTrackers: [TrackerRecord] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
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
        view = TrackersView(collectionDelegate: self, collectionDataSource: self)
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

// MARK: - UISearchResultsUpdating

extension TrackersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }

        print(searchText)
    }
}

// MARK: - SearchController

extension TrackersViewController {
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - NavigationBar

extension TrackersViewController {
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

// MARK: - UICollectionViewDataSource

extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let category = categories[safe: section] else {
            return 0
        }

        return category.trackers.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackersCollectionViewCell.identifier,
            for: indexPath
        ) as? TrackersCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        TrackerCollectionContsants.edgeInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        TrackerCollectionContsants.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        TrackerCollectionContsants.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let fullWidth = collectionView.bounds.width
        let widthWithoutPaddings = fullWidth - TrackerCollectionContsants.paddingWidth
        let cellWidth = widthWithoutPaddings / CGFloat(TrackerCollectionContsants.cellsCount)
        
        return CGSize(
            width: cellWidth,
            height: TrackerCollectionContsants.cellHeight
        )
    }
}

// MARK: - UICollectionViewDelegate

extension TrackersViewController: UICollectionViewDelegate {}
