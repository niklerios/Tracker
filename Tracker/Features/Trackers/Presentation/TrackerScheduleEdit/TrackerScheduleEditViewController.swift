//
//  TrackerScheduleEditViewController.swift
//  Tracker
//
//  Created by Nikler on 8/14/26.
//

import UIKit

final class TrackerScheduleEditViewController: UIViewController {
    typealias DidSave = (_ schedule: [Weekday]) -> Void
    
    private var customView: TrackerScheduleEditView? {
        view as? TrackerScheduleEditView
    }
    
    private var schedule: [Weekday] = []
    private var scheduleTemplate: Set<Weekday> = []
    
    private var didSaveHadler: DidSave?
    
    init(schedule: [Weekday], onSave: @escaping DidSave) {
        super.init(nibName: nil, bundle: nil)
        
        didSaveHadler = onSave
        
        self.schedule = schedule
        self.scheduleTemplate = Set(schedule)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func loadView() {
        view = TrackerScheduleEditView(
            delegate: self,
            weekdays: schedule
        )
    }
    
    private func setupUI() {
        title = "Расписание"
        navigationItem.setHidesBackButton(true, animated: false)
    }
}

extension TrackerScheduleEditViewController: TrackerScheduleEditViewDelegate {
    func didTapSaveButton() {
        navigationController?.popViewController(animated: true)
        
        let schedule = Weekday.allCases.filter { scheduleTemplate.contains($0) }
        
        didSaveHadler?(schedule)
    }
    
    func didSwitchToggleWeekday(_ weekday: Weekday, isOn: Bool) {
        if isOn {
            scheduleTemplate.insert(weekday)
        } else {
            scheduleTemplate.remove(weekday)
        }
    }
}
