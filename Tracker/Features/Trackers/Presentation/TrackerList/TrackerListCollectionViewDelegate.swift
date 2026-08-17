//
//  TrackerListCollectionViewDelegate.swift
//  Tracker
//
//  Created by Nikler on 8/11/26.
//

import UIKit

final class TrackerListCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        TrackerListCollectionLayout.edgeInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        TrackerListCollectionLayout.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        TrackerListCollectionLayout.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let fullWidth = collectionView.bounds.width
        let widthWithoutPaddings = fullWidth - TrackerListCollectionLayout.paddingWidth
        let cellWidth = widthWithoutPaddings / CGFloat(TrackerListCollectionLayout.cellsCount)
        
        return CGSize(
            width: cellWidth,
            height: TrackerListCollectionLayout.cellHeight
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let exampleHeader = TrackerListCollectionViewHeader.example
        let width = collectionView.bounds.width

        // Вычисляю высоту ровно 1 раз ,тк высота хедера всегда одинакова (текст всегда в 1 строку)
        if (exampleHeader.isFrameSet) {
            return CGSize(
                width: width,
                height: exampleHeader.height
            )
        }
        
        exampleHeader.frame.size.width = width
        
        let targetSize = CGSize(
            width: width,
            height: UIView.layoutFittingCompressedSize.height
        )
        
        let estimatedSize = exampleHeader.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        exampleHeader.frame.size.height = estimatedSize.height
        
        return estimatedSize
    }
}
