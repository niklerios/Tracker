//
//  TrackerEmojiEditView.swift
//  Tracker
//
//  Created by Nikler on 8/17/26.
//

import UIKit

final class TrackerEmojiEditView: TrackerValuePicker<Character, TrackerEmojiEditView.EmojiCell> {
    private lazy var emojis: [Character] = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]

    override init(title: String) {
        super.init(title: title)
        
        values = emojis
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TrackerValuePickerCell Base Definition
    // Не хочется светить наружу ,а приватным сделать нельзя ,пусть будет здесь
    
    final class EmojiCell: UICollectionViewCell, TrackerValuePickerCell {
        static let identifier = "EmojiCell"
        
        @UsesAutoLayout private var label = createLabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupView()
            setupSubviews()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension TrackerEmojiEditView.EmojiCell {
    func configure(with value: Character) {
        label.text = String(value)
    }
    
    func setSelection(_ isOn: Bool) {
        contentView.backgroundColor = isOn ? .colorLightGray : .clear
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
    }
    
    private func setupSubviews() {
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private static func createLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 32)
        
        return label
    }
}
