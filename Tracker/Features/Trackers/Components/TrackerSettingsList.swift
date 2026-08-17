//
//  TrackerSettingsList.swift
//  Tracker
//
//  Created by Nikler on 8/13/26.
//

import UIKit

protocol TrackerSettingsItem: UIView {}

final class TrackerSettingsList: UIStackView {
    static let itemHeight: CGFloat = 75
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addItems(_ items: [TrackerSettingsItem]) {
        for (index, item) in items.enumerated() {
            addArrangedSubview(item)
            
            if index < items.count - 1 {
                addArrangedSubview(Self.createLine())
            }
        }

        setupConstraints(for: items)
    }
    
    private func setupView() {
        backgroundColor = .colorBackground
        
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        axis = .vertical
    }
    
    private func setupConstraints(for items: [TrackerSettingsItem]) {
        NSLayoutConstraint.activate(items.map {
            $0.heightAnchor.constraint(equalToConstant: Self.itemHeight)
        })
    }
}

extension TrackerSettingsList {
    private static func createLine() -> UIView {
        let container = UIView()
        let line = UIView()

        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .colorGray

        container.addSubview(line)
        
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(
                equalToConstant: 0.5
            ),
            line.leadingAnchor.constraint(
                equalTo: container.leadingAnchor,
                constant: 16
            ),
            line.trailingAnchor.constraint(
                equalTo: container.trailingAnchor,
                constant: -16
            )
        ])
        
        return container
    }
}
