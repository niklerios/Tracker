//
//  TrackersDataManager.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import UIKit

protocol TrackersCollectionDataManagerDelegate: AnyObject {
    func visibleCategoriesDidUpdate()
}

final class TrackersDataManager: NSObject {
    private let dataRepository = TrackersDataRepository.shared
    
    private var categories: [TrackerCategory] {
        dataRepository.visibleCategories
    }
    
    weak var delegate: TrackersCollectionDataManagerDelegate?
    
    func setSelectedDate(_ date: Date) {
        dataRepository.selectedDate = date
        dataRepository.updateVisibleCategories()
        
        delegate?.visibleCategoriesDidUpdate()
    }
}

// MARK: - UICollectionViewDataSource

extension TrackersDataManager: UICollectionViewDataSource {
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
        guard
            let cell = dequeCellFrom(collectionView, indexPath: indexPath),
            let tracker = getTrackerBy(indexPath)
        else {
            return UICollectionViewCell()
        }
        
        var quantity = 4
        var checked = false
        
        let viewModel = TrackersCellViewModel(
            tracker: tracker,
            quantity: quantity,
            checked: checked
        ) {
            checked.toggle()
            quantity = checked ? 5 : 4
            
            cell.configure(
                quantityText: TrackersCellViewModel.getQuantityText(quantity),
                checked: checked
            )
        }
        
        cell.configure(viewModel: viewModel)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = dequeHeaderFrom(collectionView, indexPath: indexPath) else {
            return UICollectionReusableView()
        }
        
        if let category = categories[safe: indexPath.section] {
            header.title = category.title
        }
        
        return header
    }
    
    private func dequeHeaderFrom(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> TrackersCollectionViewHeader? {
        collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackersCollectionViewHeader.identifier,
            for: indexPath
        ) as? TrackersCollectionViewHeader
    }
    
    private func dequeCellFrom(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> TrackersCollectionViewCell? {
        collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackersCollectionViewCell.identifier,
            for: indexPath
        ) as? TrackersCollectionViewCell
    }
    
    private func getTrackerBy(_ indexPath: IndexPath) -> Tracker? {
        categories[safe: indexPath.section]?.trackers[safe: indexPath.row]
    }
}

// MARK: - UISearchResultsUpdating

extension TrackersDataManager: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let searchText = searchController.searchBar.text,
            searchText != dataRepository.searchText
        else {
            return
        }

        dataRepository.searchText = searchText
        dataRepository.updateVisibleCategories()

        delegate?.visibleCategoriesDidUpdate()
    }
}
