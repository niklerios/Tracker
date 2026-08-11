//
//  TrackersCollectionViewCell.swift
//  Tracker
//
//  Created by Nikler on 8/9/26.
//

import UIKit

final class TrackersCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrackersCollectionCell"
    
    @AutoLayout private var wrapper = createWrapper()
    
    @AutoLayout private var trackerCardView = createTrackerCardView()
    @AutoLayout private var trackerCardTitleView = createTrackerCardTitleView()
    @AutoLayout private var trackerCardEmojiView = createTrackerCardEmojiView()
    
    @AutoLayout private var quantityManagementView = createQuantityManagementView()
    @AutoLayout private var quantityManagementTitleView = createQuantityManagementTitleView()
    @AutoLayout private var quantityManagementButton = createQuantityManagementButton()
    
    private static let buttonAddImage: UIImage = .buttonPlus.withRenderingMode(.alwaysTemplate)
    private static let buttonDoneImage: UIImage = .buttonDone.withRenderingMode(.alwaysTemplate)
    
    private var quantityManagementButtonTapHandler: (() -> Void)?
    
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
    
    func configure(viewModel: TrackersCollectionViewCellViewModel) {
        configure(
            quantityText: viewModel.quantityText,
            checked: viewModel.checked
        )

        trackerCardTitleView.text = viewModel.title
        trackerCardEmojiView.text = String(viewModel.emoji)

        trackerCardView.backgroundColor = viewModel.color
        quantityManagementButton.tintColor = viewModel.color
        
        quantityManagementButtonTapHandler = viewModel.tapHandler
    }
    
    func configure(quantityText: String, checked: Bool) {
        let buttonImage = checked ? Self.buttonDoneImage : Self.buttonAddImage
        let buttonOpacity: Float = checked ? 0.3 : 1

        quantityManagementTitleView.text = quantityText

        quantityManagementButton.layer.opacity = buttonOpacity
        quantityManagementButton.setImage(buttonImage, for: .normal)
    }
    
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
            action: #selector(quantityManagementButtonDidTap),
            for: .touchUpInside
        )
        
        contentView.addSubview(wrapper)
    }
    
    private func setupConstraints() {
        let trackerCardViewMargin: CGFloat = 12
        
        NSLayoutConstraint.activate([
            wrapper.topAnchor.constraint(equalTo: contentView.topAnchor),
            wrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            wrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            trackerCardView.heightAnchor.constraint(equalToConstant: 90),

            trackerCardEmojiView.topAnchor.constraint(
                equalTo: trackerCardView.topAnchor,
                constant: trackerCardViewMargin
            ),
            trackerCardEmojiView.leadingAnchor.constraint(
                equalTo: trackerCardView.leadingAnchor,
                constant: trackerCardViewMargin
            ),
            trackerCardEmojiView.heightAnchor.constraint(equalToConstant: 24),
            trackerCardEmojiView.widthAnchor.constraint(equalToConstant: 24),
            
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
            
            quantityManagementButton.heightAnchor.constraint(equalToConstant: 34),
            quantityManagementButton.widthAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    @objc private func quantityManagementButtonDidTap() {
        quantityManagementButtonTapHandler?()
    }
}

extension TrackersCollectionViewCell {
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
