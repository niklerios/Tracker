//
//  TrackerListCollectionDataManager.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import UIKit

protocol TrackerListCollectionDataManagerDelegate: AnyObject {
    func visibleCategoriesDidUpdate()
    func trackerDidAddToVisibleCategory(section: Int, row: Int, numberOfSections: Int)
}

final class TrackerListCollectionDataManager: NSObject {
    private let dataRepository = TrackersRepository.shared
    
    private var categories: [TrackerCategory] {
        dataRepository.visibleCategories
    }
    
    weak var delegate: TrackerListCollectionDataManagerDelegate?
    
    func setSelectedDate(_ date: Date) {
        updateSelectedDate(date)
        updateCategories()
    }
    
    func createTracker(_ tracker: Tracker, forCategory category: String) {
        if let (section, row) = dataRepository.add(tracker, toCategory: category) {
            delegate?.trackerDidAddToVisibleCategory(
                section: section,
                row: row,
                numberOfSections: categories.count
            )
        }
    }
    
    private func updateSelectedDate(_ date: Date) {
        dataRepository.selectedDate = date
    }
    
    private func updateSearchText(_ text: String) {
        dataRepository.searchText = text
    }
    
    private func updateCategories() {
        dataRepository.updateVisibleCategories()
        delegate?.visibleCategoriesDidUpdate()
    }
}

// MARK: - UICollectionViewDataSource

extension TrackerListCollectionDataManager: UICollectionViewDataSource {
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

        let selectedDate = dataRepository.selectedDate
        
        let record = TrackerRecord(trackerId: tracker.id, completionDate: selectedDate)
        let records = dataRepository.getTrackerRecordsBy(tracker.id)
        let checked = records.contains(record)
        
        let viewModel = TrackerListCollectionViewCellModel(
            tracker: tracker,
            quantity: records.count,
            checked: checked,
            disabled: selectedDate > Date().startOfDay
        ) { [weak self] in
            guard let self else { return }
            
            let records = dataRepository.getTrackerRecordsBy(tracker.id)
            let checked = records.contains(record)

            if (checked) {
                dataRepository.remove(record)
            } else {
                dataRepository.add(record)
            }
            
            let updRecords = dataRepository.getTrackerRecordsBy(tracker.id)
            let updChecked = updRecords.contains(record)

            cell.updateCompletion(
                checked: updChecked,
                quantityText: TrackerListCollectionViewCellModel.quantityText(
                    from: updRecords.count
                )
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
    ) -> TrackerListCollectionViewHeader? {
        collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackerListCollectionViewHeader.identifier,
            for: indexPath
        ) as? TrackerListCollectionViewHeader
    }
    
    private func dequeCellFrom(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> TrackerListCollectionViewCell? {
        collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackerListCollectionViewCell.identifier,
            for: indexPath
        ) as? TrackerListCollectionViewCell
    }
    
    private func getTrackerBy(_ indexPath: IndexPath) -> Tracker? {
        categories[safe: indexPath.section]?.trackers[safe: indexPath.row]
    }
}

// MARK: - UISearchResultsUpdating

extension TrackerListCollectionDataManager: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let searchText = searchController.searchBar.text,
            searchText != dataRepository.searchText
        else {
            return
        }
        
        updateSearchText(searchText)
        updateCategories()
    }
}
