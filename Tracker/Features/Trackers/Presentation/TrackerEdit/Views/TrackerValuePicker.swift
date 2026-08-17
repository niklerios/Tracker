//
//  TrackerValuePicker.swift
//  Tracker
//
//  Created by Nikler on 8/17/26.
//

import UIKit

protocol TrackerValuePickerCell: UICollectionViewCell {
    associatedtype Value: Equatable
    
    static var identifier: String { get }
    
    func configure(with value: Value)
    func setSelection(_ isOn: Bool)
}

class TrackerValuePicker<Value, Cell: TrackerValuePickerCell>:
    UIView,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
where Cell.Value == Value {
    typealias OnValueChange = (_ value: Value) -> Void
    
    // MARK: - UI Elements
    
    @UsesAutoLayout private var titleLabel = createTitleLabel()
    @UsesAutoLayout private var collectionView = createCollectionView()
    
    // MARK: - Public Properties
    
    var values: [Value] = []
    var selectedValue: Value?
    var onValueChange: OnValueChange?
    
    // MARK: - Private Properties
    
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    private var collectionViewContentSizeObservation: NSKeyValueObservation?
    
    // MARK: - Initialization
    
    init(title: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        
        collectionView.register(
            Cell.self,
            forCellWithReuseIdentifier: Cell.identifier
        )
        
        setupSubviews()
        setupConstraints()
        setupCollectionViewContentSizeObservation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        collectionViewContentSizeObservation?.invalidate()
    }
    
    // MARK: - UICollectionViewDataSource Methods
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        values.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Cell.identifier,
            for: indexPath
        ) as! Cell
        let value = values[indexPath.row]
    
        cell.configure(with: value)
        cell.setSelection(value == selectedValue)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate Methods
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else {
            return
        }
              
        let selectedValue = values[indexPath.row]
        
        cell.setSelection(true)
        onValueChange?(selectedValue)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else {
            return
        }
        
        cell.setSelection(false)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = bounds.width / 6
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
    
    // MARK: - Setup
    
    private func setupSubviews() {
        collectionView.dataSource = self
        collectionView.delegate = self

        addSubviews([
            titleLabel,
            collectionView
        ])
    }
    
    private func setupConstraints() {
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(
            equalToConstant: 0
        )
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 10
            ),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 24
            ),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            collectionViewHeightConstraint!
        ])
    }
    
    private func setupCollectionViewContentSizeObservation() {
        collectionViewContentSizeObservation = collectionView.observe(
            \.contentSize,
             options: [.new]
        ) { [weak self] _, change in
            guard let self, let height = change.newValue?.height else {
                return
            }
            
            if height > 0 {
                collectionViewHeightConstraint?.constant = height
            }
        }
    }
}

// MARK: - UI Factory Methods

extension TrackerValuePicker {
    private static func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        collectionView.isScrollEnabled = false
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }
    
    private static func createTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .colorBlack
        
        return label
    }
}
