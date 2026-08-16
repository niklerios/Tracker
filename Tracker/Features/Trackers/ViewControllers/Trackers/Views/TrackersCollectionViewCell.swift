//
//  TrackersCollectionViewCell.swift
//  Tracker
//
//  Created by Nikler on 8/9/26.
//

import UIKit

final class TrackersCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrackersCollectionCell"
    
    // MARK: - UI Elements
    
    @UsesAutoLayout private var wrapper = createWrapper()
    
    @UsesAutoLayout private var trackerCardView = createTrackerCardView()
    @UsesAutoLayout private var trackerCardTitleView = createTrackerCardTitleView()
    @UsesAutoLayout private var trackerCardEmojiView = createTrackerCardEmojiView()
    
    @UsesAutoLayout private var quantityManagementView = createQuantityManagementView()
    @UsesAutoLayout private var quantityManagementTitleView = createQuantityManagementTitleView()
    @UsesAutoLayout private var quantityManagementButton = createQuantityManagementButton()
    
    // MARK: - Static Properties
    
    private static let buttonAddImage: UIImage = .buttonPlus.withRenderingMode(.alwaysTemplate)
    private static let buttonDoneImage: UIImage = .buttonDone.withRenderingMode(.alwaysTemplate)
    
    // MARK: - Public Properties
    
    private var quantityManagementButtonTapHandler: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        quantityManagementButtonTapHandler = nil
    }
    
    // MARK: - Public Methods
    
    func configure(viewModel vm: TrackersCellViewModel) {
        setupTrackerCardView(viewModel: vm)
        setupQuantityManagmentView(viewModel: vm)
    }
    
    func updateCompletion(checked: Bool, quantityText: String) {
        updateQuantityManagmentView(
            checked: checked,
            quantityText: quantityText
        )
    }
    
    // MARK: - Private methods
    
    private func setupTrackerCardView(viewModel vm: TrackersCellViewModel) {
        trackerCardTitleView.text = vm.title
        trackerCardEmojiView.text = String(vm.emoji)
        trackerCardView.backgroundColor = vm.color
    }
    
    private func setupQuantityManagmentView(viewModel vm: TrackersCellViewModel) {
        quantityManagementTitleView.text = vm.quantityText

        quantityManagementButton.tintColor = vm.color
        quantityManagementButton.isEnabled = !vm.disabled
        
        updateQuantityManagmentView(
            checked: vm.checked,
            quantityText: vm.quantityText
        )

        quantityManagementButtonTapHandler = vm.tapHandler
    }
    
    private func updateQuantityManagmentView(checked: Bool, quantityText: String) {
        let buttonImage = checked ? Self.buttonDoneImage : Self.buttonAddImage
        
        quantityManagementButton.setImage(buttonImage, for: .normal)
        quantityManagementButton.layer.opacity = checked ? 0.3 : 1
        
        quantityManagementTitleView.text = quantityText
    }
    
    // MARK: - Setup
    
    private func setupSubviews() {
        trackerCardView.addSubviews([
            trackerCardEmojiView,
            trackerCardTitleView
        ])
        
        quantityManagementView.addArrangedSubviews([
            quantityManagementTitleView,
            quantityManagementButton
        ])
        
        wrapper.addArrangedSubviews([
            trackerCardView,
            quantityManagementView
        ])
        
        quantityManagementButton.addTarget(
            self,
            action: #selector(didTapQuantityManagementButton),
            for: .touchUpInside
        )
        
        contentView.addSubview(wrapper)
    }
    
    private func setupConstraints() {
        let trackerCardViewMargin: CGFloat = 12
        
        NSLayoutConstraint.activate([
            wrapper.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            wrapper.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            wrapper.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            wrapper.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            
            trackerCardView.heightAnchor.constraint(
                equalToConstant: 90
            ),

            trackerCardEmojiView.topAnchor.constraint(
                equalTo: trackerCardView.topAnchor,
                constant: trackerCardViewMargin
            ),
            trackerCardEmojiView.leadingAnchor.constraint(
                equalTo: trackerCardView.leadingAnchor,
                constant: trackerCardViewMargin
            ),
            trackerCardEmojiView.heightAnchor.constraint(
                equalToConstant: 24
            ),
            trackerCardEmojiView.widthAnchor.constraint(
                equalToConstant: 24
            ),
            
            trackerCardTitleView.bottomAnchor.constraint(
                equalTo: trackerCardView.bottomAnchor,
                constant: -trackerCardViewMargin
            ),
            trackerCardTitleView.leadingAnchor.constraint(
                equalTo: trackerCardView.leadingAnchor,
                constant: trackerCardViewMargin
            ),
            trackerCardTitleView.trailingAnchor.constraint(
                equalTo: trackerCardView.trailingAnchor,
                constant: -trackerCardViewMargin
            ),
            
            quantityManagementButton.heightAnchor.constraint(
                equalToConstant: 34
            ),
            quantityManagementButton.widthAnchor.constraint(
                equalToConstant: 34
            )
        ])
    }
    
    @objc private func didTapQuantityManagementButton() {
        quantityManagementButtonTapHandler?()
    }
}

// MARK: - Extension

extension TrackersCollectionViewCell {
    // MARK: - UI Factory Methods

    static func createWrapper() -> UIStackView {
        let stack = UIStackView()
        
        stack.axis = .vertical

        return stack
    }
    
    static func createTrackerCardView() -> UIView {
        let view = UIView()

        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        return view
    }
    
    static func createTrackerCardTitleView() -> UILabel {
        let label = UILabel()

        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .colorWhite
        label.numberOfLines = 2
        
        return label
    }
    
    static func createTrackerCardEmojiView() -> UILabel {
        let label = UILabel()

        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.backgroundColor = UIColor(white: 1, alpha: 0.3)
        label.textAlignment = .center
        
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        
        return label
    }
    
    static func createQuantityManagementView() -> UIStackView {
        let stack = UIStackView()
        
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.alignment = .center
        
        return stack
    }
    
    static func createQuantityManagementTitleView() -> UILabel {
        let label = UILabel()

        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .colorBlack
        
        return label
    }
    
    static func createQuantityManagementButton() -> UIButton {
        UIButton(type: .system)
    }
}
