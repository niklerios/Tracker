//
//  TrackersView.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

final class TrackersView: UIView {
    @AutoLayout private var emptyResultsView = TrackersEmptyResultsView()
    @AutoLayout private var collectionView = TrackersCollectionView()
    
    init(
        collectionDelegate: UICollectionViewDelegate,
        collectionDataSource: UICollectionViewDataSource
    ) {
        super.init(frame: .zero)
        
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
        
        setupView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    private func setupView() {
        backgroundColor = .colorWhite
    }
    
    private func setupSubviews() {
        addSubviews([
//            emptyResultsView,
            collectionView,
        ])
        
        collectionView.setupConstraints(relativeTo: self)
        // emptyResultsView.setupConstraints(relativeTo: self)
    }
}
