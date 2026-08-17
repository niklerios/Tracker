//
//  TrackerColorEditView.swift
//  Tracker
//
//  Created by Nikler on 8/17/26.
//

import UIKit

final class TrackerColorEditView: TrackerValuePicker<UIColor, TrackerColorEditView.ColorCell> {
    private lazy var colors: [UIColor] = (1...18).compactMap {
        let colorName = "Color selection \($0)"

        guard let color = UIColor(named: colorName) else {
            assertionFailure("Color {\(colorName)} not found in Assets!")
            return nil
        }
        
        return color
    }
    
    override init(title: String) {
        super.init(title: title)
        
        values = colors
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TrackerValuePickerCell Definition
    // Не хочется светить наружу ,а приватным сделать нельзя ,пусть будет здесь
    
    final class ColorCell: UICollectionViewCell, TrackerValuePickerCell {
        static let identifier = "ColorCell"
        
        private var color: UIColor?
        private var sublayer = CALayer()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension TrackerColorEditView.ColorCell {
    func configure(with value: UIColor) {
        color = value
        sublayer.backgroundColor = value.cgColor
    }
    
    func setSelection(_ isOn: Bool) {
        guard let color else {
            return
        }

        contentView.backgroundColor = isOn ? color.withAlphaComponent(0.3) : .clear
    }
    
    private func setupView() {
        let radius: CGFloat = 16
        let sublayerInset: CGFloat = 3

        contentView.layer.cornerRadius = radius
        contentView.layer.masksToBounds = true
        contentView.layer.addSublayer(sublayer)
        
        sublayer.frame = contentView.bounds.insetBy(
            dx: sublayerInset,
            dy: sublayerInset
        )
        sublayer.cornerRadius = radius - sublayerInset
        sublayer.masksToBounds = true
        sublayer.borderWidth = sublayerInset
        sublayer.borderColor = UIColor.colorWhite.cgColor
    }
}
