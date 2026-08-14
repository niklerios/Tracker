//
//  TrackerEditViewController.swift
//  Tracker
//
//  Created by Nikler on 8/12/26.
//

import UIKit

final class TrackerEditViewController: UIViewController {
    typealias DidSaveTrackerHandler = (_ tracker: Tracker, _ category: String) -> Void
    
    private var trackerId = UUID()

    private var trackerTitle = "" {
        didSet { validateSettings() }
    }
    private var trackerEmoji = EmojisHelper.randomEmoji
    private var trackerColor = ColorsHelper.randomColor

    private var trackerCategory = TrackersDataMock.defaultCategory {
        didSet { validateSettings() }
    }
    private var trackerSchedule: [Weekday] = Weekday.allCases {
        didSet { validateSettings() }
    }
    
    private var didSaveTrackerHandler: DidSaveTrackerHandler?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func loadView() {
        view = TrackerEditView(delegate: self)
    }
    
    private func setupUI() {
        title = "Новая привычка"
        
        updateSelectCategorySubtitle()
        updateSetupScheduleSubtitle()
        validateSettings()
    }
    
    private func updateSelectCategorySubtitle() {
        (view as? TrackerEditView)?.selectCategorySubtitle = trackerCategory
    }
    
    private func updateSetupScheduleSubtitle() {
        (view as? TrackerEditView)?.setupScheduleSubtitle = "Пн, Вт, Ср"
    }
    
    private func validateSettings() {
        guard let view = view as? TrackerEditView else {
            return
        }
        
        let validations = [
            !trackerTitle.isEmpty,
            !trackerSchedule.isEmpty,
            !trackerCategory.isEmpty
        ]
        let isValid = validations.reduce(true) { $0 && $1 }
        
        view.setSaveButtonIsEnabled(isValid)
    }
}

extension TrackerEditViewController: TrackerEditViewDelegate {
    func didTapSaveButton() {
        let tracker = Tracker(
            id: trackerId,
            title: trackerTitle,
            color: trackerColor,
            emoji: trackerEmoji,
            schedule: trackerSchedule
        )

        // дожидаюсь окончания анимации закрытия ,чтобы было видно анимацию коллекции при обновлении
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
        print("Setup Schedule")
    }
    
    func titleEditingChanged(_ text: String?) {
        if let text {
            trackerTitle = text
        }
    }
}
