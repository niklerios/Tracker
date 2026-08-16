//
//  TrackersEmptyResultsView.swift
//  Tracker
//
//  Created by Nikler on 6/27/26.
//

import UIKit

final class TrackersEmptyResultsView: UIView {
    @UsesAutoLayout private var imageView = createImageView()
    @UsesAutoLayout private var descriptionLabel = createDescriptionLabel()
    @UsesAutoLayout private var wrapper = createWrapper()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(relativeTo parent: UIView) {
        NSLayoutConstraint.activate([
            wrapper.centerXAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerXAnchor),
            wrapper.centerYAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func setupSubviews() {
        wrapper.addArrangedSubviews([
            imageView,
            descriptionLabel
        ])
        
        addSubview(wrapper)
    }
}

extension TrackersEmptyResultsView {
    private static func createWrapper() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }
    
    private static func createImageView() -> UIImageView {
        let image: UIImage = .imageError
        let imageView = UIImageView(image: image)
        
        return imageView
    }
    
    private static func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Что будем отслеживать?"
        label.textColor = .colorBlack
        
        return label
    }
}
