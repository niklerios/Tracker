//
//  TrackerSettingsItemSwitcher.swift
//  Tracker
//
//  Created by Nikler on 8/14/26.
//

import UIKit

final class TrackerSettingsItemSwitcher: UIView, TrackerSettingsItem {
    // MARK: - UI Elements

    @UsesAutoLayout private var horizontalStack = createHorizontalStack()
    @UsesAutoLayout private var titleLabel = createTitleLabel()
    @UsesAutoLayout private var switcher = createSwitcher()
    
    // MARK: - Public properties
    
    var isOn = false {
        didSet {
            switcher.isOn = isOn
        }
    }
    
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var didSwitchToggleHandler: ((_ isOn: Bool) -> Void)?
    
    // MARK: - Initialization

    init(title: String) {
        super.init(frame: .zero)
        
        setupSubviews()
        setupConstraints()
        
        defer {
            self.title = title
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupSubviews() {
        horizontalStack.addArrangedSubviews([
            titleLabel,
            switcher
        ])
        
        switcher.addTarget(
            self,
            action: #selector(didSwitchToggle),
            for: .valueChanged
        )
        
        addSubview(horizontalStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(
                equalTo: topAnchor
            ),
            horizontalStack.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            horizontalStack.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            horizontalStack.trailingAnchor.constraint(
                equalTo: trailingAnchor
            )
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didSwitchToggle(_ sender: UISwitch) {
        didSwitchToggleHandler?(sender.isOn)
    }
}

extension TrackerSettingsItemSwitcher {
    // MARK: - UI Factory Methods

    private static func createTitleLabel() -> UILabel {
        let label = UILabel()

        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .colorBlack
        
        return label
    }
    
    private static func createHorizontalStack() -> UIStackView {
        let stack = UIStackView()
        
        stack.alignment = .center
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }
    
    private static func createSwitcher() -> UISwitch {
        let switcher = UISwitch()
        
        switcher.onTintColor = .colorBlue
        
        return switcher
    }
}
