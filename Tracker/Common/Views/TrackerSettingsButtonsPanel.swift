//
//  TrackerSettingsButtonsPanel.swift
//  Tracker
//
//  Created by Nikler on 8/14/26.
//

import UIKit

final class TrackerSettingsButtonsPanel: UIStackView {
    static let buttonHeight: CGFloat = 60

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutMargins = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        isLayoutMarginsRelativeArrangement = true
        spacing = 8
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addButtons(_ buttons: [TrackerSettingsButton]) {
        addArrangedSubviews(buttons)
        
        buttons.forEach {
            $0.heightAnchor.constraint(equalToConstant: Self.buttonHeight).isActive = true
        }
    }
}
