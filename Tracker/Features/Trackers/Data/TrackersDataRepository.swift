//
//  TrackersDataRepository.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import Foundation

protocol TrackersDataRepositoryProtocol {
    typealias Categories = [TrackerCategory]
    typealias Records = Set<TrackerRecord>

    var selectedDate: Date { get set }
    var searchText: String { get set }
    var visibleCategories: Categories { get }
    
    func updateVisibleCategories()
    func getTrackerRecordsBy(_ trackerId: UUID) -> Records
    
    func add(_ record: TrackerRecord)
    func remove(_ record: TrackerRecord)
}

final class TrackersDataRepository: TrackersDataRepositoryProtocol {
    // static let shared = TrackersDataRepository()
    
    // @todo - Для тестирования начальные данные замоканы
    static let shared = TrackersDataRepository(
        categories: TrackersDataMock.example.categories,
        records: TrackersDataMock.example.completedTrackers
    )
    
    // Source data
    private var categories: Categories
    private var completedTrackers: Records
    
    // Cache
    private var dateCategoriesCache: Dictionary<Date, Categories> = [:]
    private var trackerRecordsCache: Dictionary<UUID, Records> = [:]
    
    // Public
    var selectedDate = DateHelper.startOfDay(Date()) {
        didSet {
            searchText = ""
        }
    }
    var searchText = ""
    
    private(set) var visibleCategories: Categories = []
    
    convenience init() {
        self.init(categories: [], records: [])
    }
    
    init(categories: Categories, records: Records) {
        self.categories = categories
        self.completedTrackers = records
        
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
