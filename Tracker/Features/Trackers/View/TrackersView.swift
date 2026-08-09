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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .colorWhite
    }
    
    private func setupSubviews() {
        addSubviews([
            emptyResultsView,
            collectionView,
        ])
        
        emptyResultsView.setupConstraints(relativeTo: self)
    }
}
