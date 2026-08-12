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
    
    private var collectionIsEmpty: Bool {
        collectionView.numberOfSections == 0
    }
    
    private var collectionViewIsVisible: Bool = false {
        didSet {
            collectionView.isHidden = !collectionViewIsVisible
            emptyResultsView.isHidden = collectionViewIsVisible
        }
    }
    
    init(
        collectionDelegate: UICollectionViewDelegate,
        collectionDataSource: UICollectionViewDataSource
    ) {
        super.init(frame: .zero)
        
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
        
        setupView()
        setupSubviews()
        
        reloadCollectionViewData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func insertRowToCollectionView(indexPath: IndexPath, numberOfSections: Int) {
        if (collectionIsEmpty) {
            collectionViewIsVisible = true
        }
        
        collectionView.performBatchUpdates {
            if numberOfSections != collectionView.numberOfSections {
                collectionView.insertSections(IndexSet(integer: indexPath.section))
            }

            collectionView.insertItems(at: [indexPath])
        }
    }
    
    func reloadCollectionViewData() {
        collectionView.reloadData()
        collectionViewIsVisible = !collectionIsEmpty
    }
    
    private func setupView() {
        backgroundColor = .colorWhite
    }
    
    private func setupSubviews() {
        addSubviews([
            emptyResultsView,
            collectionView,
        ])
        
        collectionView.setupConstraints(relativeTo: self)
        emptyResultsView.setupConstraints(relativeTo: self)
    }
}
