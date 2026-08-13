//
//  TrackerSettingsItemLink.swift
//  Tracker
//
//  Created by Nikler on 8/13/26.
//

import UIKit

final class TrackerSettingsItemLink: UIView, TrackerSettingsItem {
    @AutoLayout private var wrapper = UIButton(type: .custom)
    
    @AutoLayout private var verticalStack = createVerticalStack()
    @AutoLayout private var horizontalStack = createHorizontalStack()
    
    @AutoLayout private var titleLabel = createTitleLabel()
    @AutoLayout private var subtitleLabel = createSubtitleLabel()
    
    @AutoLayout private var chevronRightIcon = UIImageView(image: .chevronRight)
    
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle = "" {
        didSet {
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle.isEmpty
        }
    }
    
    var didTapHandler: (() -> Void)?
    
    convenience init(title: String, subtitle: String = "") {
        self.init(frame: .zero)
        
        defer {
            self.title = title
            self.subtitle = subtitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        verticalStack.addArrangedSubviews([
            titleLabel,
            subtitleLabel
        ])
        
        horizontalStack.addArrangedSubviews([
            verticalStack,
            chevronRightIcon
        ])
        
        wrapper.addSubview(horizontalStack)

        wrapper.addTarget(
            self,
            action: #selector(didTap),
            for: .touchUpInside
        )

        addSubview(wrapper)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wrapper.topAnchor.constraint(
                equalTo: topAnchor
            ),
            wrapper.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            wrapper.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            wrapper.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            
            horizontalStack.topAnchor.constraint(
                equalTo: wrapper.topAnchor
            ),
            horizontalStack.bottomAnchor.constraint(
                equalTo: wrapper.bottomAnchor
            ),
            horizontalStack.leadingAnchor.constraint(
                equalTo: wrapper.leadingAnchor
            ),
            horizontalStack.trailingAnchor.constraint(
                equalTo: wrapper.trailingAnchor,
                constant: -16
            ),
            
            chevronRightIcon.heightAnchor.constraint(
                equalToConstant: 24
            ),
            chevronRightIcon.widthAnchor.constraint(
                equalToConstant: 24
            )
        ])
    }
    
    @objc private func didTap() {
        didTapHandler?()
    }
}

extension TrackerSettingsItemLink {
    private static func createVerticalStack() -> UIStackView {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .equalCentering
        
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }
    
    private static func createHorizontalStack() -> UIStackView {
        let stack = UIStackView()
        
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
        
        return stack
    }
    
    private static func createTitleLabel() -> UILabel {
        let label = UILabel()

        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .colorBlack
        
        return label
    }
    
    private static func createSubtitleLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .colorGray
        
        return label
    }
}
