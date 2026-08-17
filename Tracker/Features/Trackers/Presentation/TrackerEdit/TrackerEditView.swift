//
//  TrackerEditView.swift
//  Tracker
//
//  Created by Nikler on 8/12/26.
//

import UIKit

protocol TrackerEditViewDelegate: AnyObject {
    func didTapSaveButton()
    func didTapCancelButton()
    func didTapSelectCategory()
    func didTapSetupSchedule()
    func titleEditingChanged(_ text: String?)
    func didSelectEmoji(_ emoji: Character)
    func didSelectColor(_ color: UIColor)
}

final class TrackerEditView: UIView {
    // MARK: - UI Elements
    
    @UsesAutoLayout private var scrollView = UIScrollView()
    
    @UsesAutoLayout private var buttonsPanel = TrackerSettingsButtonsPanel()
    @UsesAutoLayout private var cancelButton = TrackerSettingsButton(
        style: .outline,
        title: "Отменить"
    )
    @UsesAutoLayout private var saveButton = TrackerSettingsButton(
        style: .fill,
        title: "Создать"
    )
    
    @UsesAutoLayout private var settingsListMainSection = TrackerSettingsList()
    @UsesAutoLayout private var settingsItemSetupTitle = TrackerSettingsItemTextField(
        placeholder: "Введите название трекера"
    )
    
    @UsesAutoLayout private var settingsListSecondarySection = TrackerSettingsList()
    @UsesAutoLayout private var settingsItemSelectCategory = TrackerSettingsItemLink(
        title: "Категория"
    )
    @UsesAutoLayout private var settingsItemSetupSchedule = TrackerSettingsItemLink(
        title: "Расписание"
    )
    
    @UsesAutoLayout private var colorEditView = TrackerColorEditView(
        title: "Цвет"
    )
    @UsesAutoLayout private var emojiEditView = TrackerEmojiEditView(
        title: "Emoji"
    )
    
    // MARK: - Public Properties
    
    var selectCategorySubtitle = "" {
        didSet {
            settingsItemSelectCategory.subtitle = selectCategorySubtitle
        }
    }
    
    var setupScheduleSubtitle = "" {
        didSet {
            settingsItemSetupSchedule.subtitle = setupScheduleSubtitle
        }
    }
    
    var selectedColor: UIColor? {
        didSet {
            colorEditView.selectedValue = selectedColor
        }
    }
    
    var selectedEmoji: Character? {
        didSet {
            emojiEditView.selectedValue = selectedEmoji
        }
    }
    
    weak var delegate: TrackerEditViewDelegate?
    
    // MARK: - Initialization
    
    init(delegate: TrackerEditViewDelegate) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        
        setupView()
        setupSubviews()
        setupHandlers()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setSaveButtonIsEnabled(_ isEnabled: Bool) {
        saveButton.isEnabled = isEnabled
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .colorWhite
    }
    
    private func setupSubviews() {
        settingsListMainSection.addItems([
            settingsItemSetupTitle
        ])
        
        settingsListSecondarySection.addItems([
            settingsItemSelectCategory,
            settingsItemSetupSchedule
        ])
        
        buttonsPanel.addButtons([
            cancelButton,
            saveButton
        ])
        
        scrollView.addSubviews([
            settingsListMainSection,
            settingsListSecondarySection,
            emojiEditView,
            colorEditView,
            buttonsPanel
        ])
        
        addSubview(scrollView)
    }
    
    private func setupHandlers() {
        cancelButton.didTapHandler = { [weak self] in
            self?.delegate?.didTapCancelButton()
        }
        saveButton.didTapHandler = { [weak self] in
            self?.delegate?.didTapSaveButton()
        }
        settingsItemSelectCategory.didTapHandler = { [weak self] in
            self?.delegate?.didTapSelectCategory()
        }
        settingsItemSetupSchedule.didTapHandler = { [weak self] in
            self?.delegate?.didTapSetupSchedule()
        }
        settingsItemSetupTitle.editingChangedHandler = { [weak self] in
            self?.delegate?.titleEditingChanged($0)
        }
        emojiEditView.onValueChange = { [weak self] in
            self?.delegate?.didSelectEmoji($0)
        }
        colorEditView.onValueChange = { [weak self] in
            self?.delegate?.didSelectColor($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            
            settingsListMainSection.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 24
            ),
            settingsListMainSection.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            settingsListMainSection.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            
            settingsListSecondarySection.topAnchor.constraint(
                equalTo: settingsListMainSection.bottomAnchor,
                constant: 24
            ),
            settingsListSecondarySection.leadingAnchor.constraint(
                equalTo: settingsListMainSection.leadingAnchor
            ),
            settingsListSecondarySection.trailingAnchor.constraint(
                equalTo: settingsListMainSection.trailingAnchor
            ),
            
            emojiEditView.topAnchor.constraint(
                equalTo: settingsListSecondarySection.bottomAnchor,
                constant: 32
            ),
            emojiEditView.leadingAnchor.constraint(
                equalTo: settingsListMainSection.leadingAnchor
            ),
            emojiEditView.trailingAnchor.constraint(
                equalTo: settingsListMainSection.trailingAnchor
            ),
            
            colorEditView.topAnchor.constraint(
                equalTo: emojiEditView.bottomAnchor,
                constant: 32
            ),
            colorEditView.leadingAnchor.constraint(
                equalTo: settingsListMainSection.leadingAnchor
            ),
            colorEditView.trailingAnchor.constraint(
                equalTo: settingsListMainSection.trailingAnchor
            ),
            
            buttonsPanel.topAnchor.constraint(
                equalTo: colorEditView.bottomAnchor,
                constant: 40
            ),
            buttonsPanel.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            buttonsPanel.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            buttonsPanel.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            )
        ])
    }
}
