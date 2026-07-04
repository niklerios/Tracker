//
//  TrackersEmptyView.swift
//  Tracker
//
//  Created by Nikler on 6/27/26.
//

import UIKit

final class TrackersEmptyView: UIView {
    private lazy var imageView = createImageView()
    private lazy var descriptionLabel = createDescriptionLabel("Что будем отслеживать?")
    private lazy var wrapper = createWrapper()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyConstraints(relativeTo parent: UIView) {
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
    
    private func createWrapper() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView.autoLayout()
    }
    
    private func createImageView() -> UIImageView {
        let image: UIImage = .imageError
        let imageView = UIImageView(image: image)
        
        return imageView.autoLayout()
    }
    
    private func createDescriptionLabel(_ text: String) -> UILabel {
        let label = UILabel()
        
        label.text = text
        label.textColor = .colorBlack
        
        return label.autoLayout()
    }
}
