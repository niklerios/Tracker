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
}

final class TrackerEditView: UIView {
    @AutoLayout private var buttonsStack = createButtonsStack()
    @AutoLayout private var cancelButton = createCancelButton()
    @AutoLayout private var saveButton = createSaveButton()
    
    @AutoLayout private var settingsListMainSection = TrackerSettingsList()
    @AutoLayout private var settingsItemSetupTitle = TrackerSettingsItemTextField(
        placeholder: "Введите название трекера"
    )
    
    @AutoLayout private var settingsListSecondarySection = TrackerSettingsList()
    @AutoLayout private var settingsItemSelectCategory = TrackerSettingsItemLink(
        title: "Категория"
    )
    @AutoLayout private var settingsItemSetupSchedule = TrackerSettingsItemLink(
        title: "Расписание"
    )
    
    weak var delegate: TrackerEditViewDelegate?
    
    init(delegate: TrackerEditViewDelegate) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        
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
        settingsListMainSection.addItems([
            settingsItemSetupTitle
        ])
        
        settingsListSecondarySection.addItems([
            settingsItemSelectCategory,
            settingsItemSetupSchedule
        ])
        
        buttonsStack.addArrangedSubviews([
            cancelButton,
            saveButton
        ])
        
        addSubviews([
            settingsListMainSection,
            settingsListSecondarySection,
            buttonsStack
        ])
        
        cancelButton.addTarget(
            self,
            action: #selector(didTapCancelButton),
            for: .touchUpInside
        )
        
        saveButton.addTarget(
            self,
            action: #selector(didTapSaveButton),
            for: .touchUpInside
        )
        
        settingsItemSelectCategory.didTapHandler = { [weak self] in
            self?.delegate?.didTapSelectCategory()
        }
        settingsItemSetupSchedule.didTapHandler = { [weak self] in
            self?.delegate?.didTapSetupSchedule()
        }
        settingsItemSetupTitle.editingChangedHandler = { [weak self] in
            self?.delegate?.titleEditingChanged($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsListMainSection.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
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
            
            buttonsStack.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            ),
            buttonsStack.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            buttonsStack.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),

            cancelButton.heightAnchor.constraint(
                equalToConstant: UIButton.customHeight
            ),
            saveButton.heightAnchor.constraint(
                equalToConstant: UIButton.customHeight
            )
        ])
    }
    
    @objc private func didTapSaveButton() {
        delegate?.didTapSaveButton()
    }
    
    @objc private func didTapCancelButton() {
        delegate?.didTapCancelButton()
    }
}

extension TrackerEditView {
    private static func createButtonsStack() -> UIStackView {
        let stack = UIStackView()

        stack.layoutMargins = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.spacing = 8
        stack.distribution = .fillEqually
        
        return stack
    }
    
    private static func createCancelButton() -> UIButton {
        let button = UIButton(withStyle: .customOutline)
        
        button.setTitle("Отменить", for: .normal)
        
        return button
    }
    
    private static func createSaveButton() -> UIButton {
        let button = UIButton(withStyle: .customFill)
        
        button.setTitle("Создать", for: .normal)
        
        return button
    }
}
