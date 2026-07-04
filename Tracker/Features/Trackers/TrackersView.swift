//
//  TrackersView.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

final class TrackersView: UIView {
    @AutoLayout private var emptyView = TrackersEmptyView()
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
            emptyView,
            collectionView,
        ])

        setupSubviewsConstraints()
    }
    
    private func setupSubviewsConstraints() {
        emptyView.applyConstraints(relativeTo: self)
    }
}
