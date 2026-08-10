//
//  TrackersCollectionViewHeader.swift
//  Tracker
//
//  Created by Nikler on 8/10/26.
//

import UIKit

final class TrackersCollectionViewHeader: UICollectionReusableView {
    static let identifier = "TrackersCollectionHeader"
    
    // Example для динамического рассчета высоты
    static let example = createExample()
    
    @AutoLayout private var titleLabel = createTitleLabel()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var isFrameSet: Bool {
        bounds.size.width > 0 && bounds.size.height > 0
    }
    
    var height: CGFloat {
        bounds.size.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title = nil
    }
    
    private func setupView() {
        layoutMargins = TrackerCollectionContsants.headerEdgeInsets
    }
    
    private func setupSubviews() {
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}

extension TrackersCollectionViewHeader {
    static private func createTitleLabel() -> UILabel {
        let label = UILabel()

        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .colorBlack
        label.numberOfLines = 1
        
        return label
    }
    
    static private func createExample() -> Self {
        let example = Self()
        
        example.title = "Example"
        
        return example
    }
}
