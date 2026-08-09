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
        
        register(
            TrackersCollectionViewCell.self,
            forCellWithReuseIdentifier: TrackersCollectionViewCell.identifier
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(relativeTo parent: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
