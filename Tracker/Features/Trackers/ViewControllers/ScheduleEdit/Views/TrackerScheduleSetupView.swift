//
//  TrackerScheduleSetupView.swift
//  Tracker
//
//  Created by Nikler on 8/14/26.
//

import UIKit

protocol TrackerScheduleSetupViewDelegate: AnyObject {
    func didTapSaveButton()
    func didSwitchToggleWeekday(_ weekday: Weekday, isOn: Bool)
}

final class TrackerScheduleSetupView: UIView {
    @UsesAutoLayout private var settingsListSection = TrackerSettingsList()
    
    @UsesAutoLayout private var settingsItems = Weekday.allCases.map {
        TrackerSettingsItemSwitcher(title: $0.toDayText().capitalized)
    }

    @UsesAutoLayout private var buttonsPanel = TrackerSettingsButtonsPanel()
    @UsesAutoLayout private var saveButton = TrackerSettingsButton(
        style: .fill,
        title: "Готово"
    )
    
    weak var delegate: TrackerScheduleSetupViewDelegate?
    
    init(delegate: TrackerScheduleSetupViewDelegate, weekdays: [Weekday] = []) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        
        setupSwitchers(from: weekdays)
        setupSwitchersHandlers()
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .colorWhite
    }
    
    private func setupSubviews() {
        buttonsPanel.addButtons([saveButton])
        
        settingsListSection.addItems(settingsItems)
        
        addSubviews([
            settingsListSection,
            buttonsPanel
        ])
        
        saveButton.didTapHandler = { [weak self] in
            self?.delegate?.didTapSaveButton()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsListSection.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            settingsListSection.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            settingsListSection.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),

            buttonsPanel.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            ),
            buttonsPanel.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            buttonsPanel.trailingAnchor.constraint(
                equalTo: trailingAnchor
            )
        ])
    }
    
    private func setupSwitchersHandlers() {
        for (index, switcher) in settingsItems.enumerated() {
            switcher.didSwitchToggleHandler = { [weak self] in
                guard let weekday = Weekday.allCases[safe: index] else {
                    return
                }

                self?.delegate?.didSwitchToggleWeekday(weekday, isOn: $0)
            }
        }
    }
    
    private func setupSwitchers(from weekdays: [Weekday]) {
        guard weekdays.count > 0 else {
            return
        }
        
        for weekday in weekdays {
            guard let index = Weekday.allCases.firstIndex(of: weekday) else {
                continue
            }
            
            settingsItems[safe: index]?.isOn = true
        }
    }
}
