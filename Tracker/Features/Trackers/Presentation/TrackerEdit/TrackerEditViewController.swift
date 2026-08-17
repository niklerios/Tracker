//
//  TrackerEditViewController.swift
//  Tracker
//
//  Created by Nikler on 8/12/26.
//

import UIKit

final class TrackerEditViewController: UIViewController {
    typealias DidSaveTrackerHandler = (_ tracker: Tracker, _ category: String) -> Void
    
    // MARK: - State Properties
    
    private var trackerId = UUID()

    private var trackerTitle: String? {
        didSet {
            validateSettings()
        }
    }
    private var trackerEmoji: Character? {
        didSet {
            validateSettings()
        }
    }
    private var trackerColor: UIColor? {
        didSet {
            validateSettings()
        }
    }
    private var trackerCategory = TrackersMock.defaultCategory {
        didSet {
            validateSettings()
            setupCategorySubtitle()
        }
    }
    private var trackerSchedule: [Weekday]? {
        didSet {
            validateSettings()
            setupScheduleSubtitle()
        }
    }
    
    // MARK: - Private Properties
    
    private var didSaveTrackerHandler: DidSaveTrackerHandler?
    
    private var customView: TrackerEditView? {
        view as? TrackerEditView
    }
    
    // MARK: - Initialization
    
    init(tracker: Tracker?, onSaveTracker: @escaping DidSaveTrackerHandler) {
        super.init(nibName: nil, bundle: nil)
        
        didSaveTrackerHandler = onSaveTracker
        
        if let tracker {
            trackerId = tracker.id
            trackerTitle = tracker.title
            trackerEmoji = tracker.emoji
            trackerColor = tracker.color
            trackerSchedule = tracker.schedule
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func loadView() {
        view = TrackerEditView(delegate: self)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        title = "Новая привычка"
        
        setupCategorySubtitle()
        setupScheduleSubtitle()

        setupSelectedEmoji()
        setupSelectedColor()

        validateSettings()
    }
    
    private func setupSelectedEmoji() {
        customView?.selectedEmoji = trackerEmoji
    }
    
    private func setupSelectedColor() {
        customView?.selectedColor = trackerColor
    }
    
    private func setupCategorySubtitle() {
        customView?.selectCategorySubtitle = trackerCategory
    }
    
    private func setupScheduleSubtitle() {
        guard let trackerSchedule else {
            return
        }

        let text = trackerSchedule.count == Weekday.allCases.count
            ? "Каждый день"
            : Weekday.weekdaysListToShortText(trackerSchedule)

        customView?.setupScheduleSubtitle = text
    }
    
    // MARK: - Private methods
    
    private func validateSettings() {
        guard
            let trackerTitle,
            let trackerSchedule,
            let _ = trackerEmoji,
            let _ = trackerColor,
            !trackerTitle.isEmpty,
            !trackerSchedule.isEmpty
        else {
            customView?.setSaveButtonIsEnabled(false)
            return
        }
        
        customView?.setSaveButtonIsEnabled(true)
    }
}

// MARK: - TrackerEditViewDelegate

extension TrackerEditViewController: TrackerEditViewDelegate {
    func didTapSaveButton() {
        guard
            let trackerTitle,
            let trackerColor,
            let trackerEmoji,
            let trackerSchedule
        else {
            return
        }

        let tracker = Tracker(
            id: trackerId,
            title: trackerTitle,
            color: trackerColor,
            emoji: trackerEmoji,
            schedule: trackerSchedule
        )

        dismiss(animated: true) { [weak self] in
            guard let self else {
                return
            }

            didSaveTrackerHandler?(tracker, trackerCategory)
        }
    }
    
    func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    func didTapSelectCategory() {
        // todo - обработка в другом спринте
        print("Select Category")
    }
    
    func didTapSetupSchedule() {
        let scheduleEditViewController = TrackerScheduleEditViewController(
            schedule: trackerSchedule
        ) { [weak self] updatedSchedule in
            self?.trackerSchedule = updatedSchedule
        }

        navigationController?.pushViewController(
            scheduleEditViewController,
            animated: true
        )
    }
    
    func titleEditingChanged(_ text: String?) {
        if let text {
            trackerTitle = text
        }
    }
    
    func didSelectEmoji(_ emoji: Character) {
        trackerEmoji = emoji
    }
    
    func didSelectColor(_ color: UIColor) {
        trackerColor = color
    }
}
