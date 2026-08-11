//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

let tracker1 = Tracker(
    id: UUID(),
    title: "Учить iOS и Swift",
    color: .colorSelection1,
    emoji: "😀",
    schedule: [.monday, .sunday, .friday]
)

let tracker2 = Tracker(
    id: UUID(),
    title: "Помыть полы",
    color: .colorSelection2,
    emoji: "❤️",
    schedule: [.monday, .sunday, .friday]
)

let tracker3 = Tracker(
    id: UUID(),
    title: "Почитать Objective-C",
    color: .colorSelection3,
    emoji: "👌",
    schedule: [.monday, .sunday, .friday]
)

let tracker4 = Tracker(
    id: UUID(),
    title: "Приготовить поесть",
    color: .colorSelection4,
    emoji: "👀",
    schedule: [.monday, .sunday, .friday]
)

let tracker5 = Tracker(
    id: UUID(),
    title: "Намыть посуду",
    color: .colorSelection5,
    emoji: "🙈",
    schedule: [.monday, .sunday, .friday]
)

let testCategories = [
    TrackerCategory(
        title: "Test Category",
        trackers: [
            tracker1,
            tracker2,
            tracker3,
            tracker4,
            tracker5
        ]
    ),
    TrackerCategory(
        title: "Another Category",
        trackers: [
            tracker1,
            tracker2,
            tracker3
        ]
    )
]

final class TrackersViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var categories: [TrackerCategory] = testCategories
    private var completedTrackers: [TrackerRecord] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: .trackers,
            selectedImage: .trackers,
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = TrackersView(collectionDelegate: self, collectionDataSource: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupSearchController()
    }
    
    @objc private func didTapAddButton() {
        print(#function)
    }
    
    @objc private func didChangeSelectedDate(_ sender: UIDatePicker) {
        print(sender.date)
    }
}

// MARK: - UISearchResultsUpdating

extension TrackersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }

        print(searchText)
    }
}

// MARK: - SearchController

extension TrackersViewController {
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - NavigationBar

extension TrackersViewController {
    private func setupNavigationBar() {
        title = "Трекеры"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .addTracker,
            style: .plain,
            target: self,
            action: #selector(didTapAddButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: createDatePicker()
        )
    }
    
    private func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(
            self,
            action: #selector(didChangeSelectedDate),
            for: .valueChanged
        )
        
        return datePicker
    }
}

// MARK: - UICollectionViewDataSource

extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let category = categories[safe: section] else {
            return 0
        }

        return category.trackers.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = dequeCellFrom(collectionView, indexPath: indexPath),
            let tracker = getTrackerBy(indexPath)
        else {
            return UICollectionViewCell()
        }
        
        var quantity = 4
        var checked = false
        
        let viewModel = TrackersCollectionViewCellViewModel(
            tracker: tracker,
            quantity: quantity,
            checked: checked
        ) {
            checked.toggle()
            quantity = checked ? 5 : 4
            
            cell.configure(
                quantityText: TrackersCollectionViewCellViewModel.getQuantityText(quantity),
                checked: checked
            )
        }
        
        cell.configure(viewModel: viewModel)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = dequeHeaderFrom(collectionView, indexPath: indexPath) else {
            return UICollectionReusableView()
        }
        
        if let category = categories[safe: indexPath.section] {
            header.title = category.title
        }
        
        return header
    }
    
    private func dequeHeaderFrom(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> TrackersCollectionViewHeader? {
        collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackersCollectionViewHeader.identifier,
            for: indexPath
        ) as? TrackersCollectionViewHeader
    }
    
    private func dequeCellFrom(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> TrackersCollectionViewCell? {
        collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackersCollectionViewCell.identifier,
            for: indexPath
        ) as? TrackersCollectionViewCell
    }
    
    private func getTrackerBy(_ indexPath: IndexPath) -> Tracker? {
        categories[safe: indexPath.section]?.trackers[safe: indexPath.row]
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        TrackersCollectionContsants.edgeInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        TrackersCollectionContsants.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        TrackersCollectionContsants.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let fullWidth = collectionView.bounds.width
        let widthWithoutPaddings = fullWidth - TrackersCollectionContsants.paddingWidth
        let cellWidth = widthWithoutPaddings / CGFloat(TrackersCollectionContsants.cellsCount)
        
        return CGSize(
            width: cellWidth,
            height: TrackersCollectionContsants.cellHeight
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let exampleHeader = TrackersCollectionViewHeader.example
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

// MARK: - UICollectionViewDelegate

extension TrackersViewController: UICollectionViewDelegate {}
