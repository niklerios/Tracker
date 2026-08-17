//
//  TrackersRepository.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import Foundation

protocol TrackersRepositoryProtocol {
    typealias Categories = [TrackerCategory]
    typealias Records = Set<TrackerRecord>

    var selectedDate: Date { get set }
    var searchText: String { get set }
    var visibleCategories: Categories { get }
    
    func updateVisibleCategories()
    func getTrackerRecordsBy(_ trackerId: UUID) -> Records
    
    func add(_ tracker: Tracker, toCategory categoryTitle: String) -> (section: Int, row: Int)?
    func add(_ record: TrackerRecord)
    func remove(_ record: TrackerRecord)
}

final class TrackersRepository: TrackersRepositoryProtocol {
    static let shared = TrackersRepository(withMock: true)
    
    // Source data
    private var categories: Categories
    private var completedTrackers: Records
    
    // Cache
    private var dateCategoriesCache: Dictionary<Date, Categories> = [:]
    private var trackerRecordsCache: Dictionary<UUID, Records> = [:]
    
    // Public
    var selectedDate = Date().startOfDay {
        didSet {
            searchText = ""
        }
    }
    var searchText = ""
    
    private(set) var visibleCategories: Categories = []
    
    private init(withMock: Bool = false) {
        let defaultCategory = TrackerCategory(
            title: TrackersMock.defaultCategory,
            trackers: []
        )
        
        if (withMock) {
            self.categories = TrackersMock.example.categories
            self.completedTrackers = TrackersMock.example.completedTrackers
        } else {
            self.categories = [defaultCategory]
            self.completedTrackers = []
        }
        
        updateVisibleCategories()
    }
    
    func updateVisibleCategories() {
        visibleCategories = combineFilters(
            filterTrackersByDate,
            filterTrackersBySearchText,
            excludeEmptyCategories
        )
    }
    
    func getTrackerRecordsBy(_ trackerId: UUID) -> Records {
        if let cachedRecords = trackerRecordsCache[trackerId] {
            return cachedRecords
        }
        
        let records = completedTrackers.filter { $0.trackerId == trackerId }
        
        trackerRecordsCache[trackerId] = records
        
        return records
    }
    
    func add(_ tracker: Tracker, toCategory categoryTitle: String) -> (section: Int, row: Int)? {
        guard
            let categoryIndex = (categories.firstIndex { $0.title == categoryTitle }),
            let category = categories[safe: categoryIndex]
        else {
            return nil
        }
        
        let updatedCategory = TrackerCategory(
            title: category.title,
            trackers: category.trackers + [tracker]
        )
        
        categories[categoryIndex] = updatedCategory
        // todo - достаточно заморочно обновлять кеши по дням ,решил тут просто чистить их...
        dateCategoriesCache.removeAll()
        // ...но обновлять кеш для текущей выборки
        updateVisibleCategories()
        
        if
            let visibleCategoryIndex = (visibleCategories.firstIndex { $0.title == categoryTitle }),
            let visibleCategory = visibleCategories[safe: visibleCategoryIndex],
            let trackerIndex = (visibleCategory.trackers.firstIndex { $0.id == tracker.id })
        {
            return (visibleCategoryIndex, trackerIndex)
        } else {
            return nil
        }
    }
    
    func add(_ record: TrackerRecord) {
        completedTrackers.insert(record)
        trackerRecordsCache[record.trackerId]?.insert(record)
    }
    
    func remove(_ record: TrackerRecord) {
        completedTrackers.remove(record)
        trackerRecordsCache[record.trackerId]?.remove(record)
    }
    
    private func combineFilters(_ filters: ((Categories) -> Categories)...) -> Categories {
        filters.reduce(categories) { $1($0) }
    }
    
    private func filterTrackersByDate(_ categories: Categories) -> Categories {
        if let cachedCategories = dateCategoriesCache[selectedDate] {
            return cachedCategories
        }
        
        let categories = categories.map { category in
            TrackerCategory(
                title: category.title,
                trackers: category.trackers.filter { tracker in
                    tracker.schedule.contains(Weekday(from: selectedDate))
                }
            )
        }
        
        dateCategoriesCache[selectedDate] = categories
        
        return categories
    }
    
    private func filterTrackersBySearchText(_ categories: Categories) -> Categories {
        categories.map { category in
            TrackerCategory(
                title: category.title,
                trackers: category.trackers.filter { tracker in
                    searchText.isEmpty || tracker.title.localizedStandardContains(searchText)
                }
            )
        }
    }
    
    private func excludeEmptyCategories(_ categories: Categories) -> Categories {
        categories.filter { !$0.trackers.isEmpty }
    }
}
