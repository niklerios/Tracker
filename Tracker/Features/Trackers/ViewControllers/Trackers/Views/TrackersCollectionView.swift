//
//  CollectionView.swift
//  Tracker
//
//  Created by Nikler on 6/27/26.
//

import UIKit

final class TrackersCollectionView: UICollectionView {    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        setupView()
        registerCollectionItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(relativeTo parent: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            trailingAnchor.constraint(equalTo: parent.trailingAnchor)
        ])
    }
    
    private func setupView() {
        contentInset = UIEdgeInsets(
            top: 18,
            left: 0,
            bottom: 0,
            right: 0
        )
    }
    
    private func registerCollectionItems() {
        register(
            TrackersCollectionViewCell.self,
            forCellWithReuseIdentifier: TrackersCollectionViewCell.identifier
        )
        register(
            TrackersCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackersCollectionViewHeader.identifier
        )
    }
}
