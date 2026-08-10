//
//  TrackersCollectionViewCell.swift
//  Tracker
//
//  Created by Nikler on 8/9/26.
//

import UIKit

final class TrackersCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrackersCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .red
    }
}
