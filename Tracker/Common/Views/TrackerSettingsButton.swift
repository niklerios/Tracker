//
//  TrackerSettingsButton.swift
//  Tracker
//
//  Created by Nikler on 8/14/26.
//

import UIKit

final class TrackerSettingsButton: UIButton {
    enum Style { case fill, outline }
    
    var didTapHandler: (() -> Void)?

    init(style: Style, title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        if case .fill = style {
            backgroundColor = .colorBlack

            setTitleColor(.colorWhite, for: .normal)
        }
        
        if case .outline = style {
            backgroundColor = .clear
            
            layer.borderWidth = 1
            layer.borderColor = UIColor.colorRed.cgColor

            setTitleColor(.colorRed, for: .normal)
        }
        
        addTarget(
            self,
            action: #selector(didTap),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTap() {
        didTapHandler?()
    }
}
