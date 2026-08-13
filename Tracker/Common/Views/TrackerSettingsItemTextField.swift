//
//  TrackerSettingsItemTextField.swift
//  Tracker
//
//  Created by Nikler on 8/13/26.
//

import UIKit

final class TrackerSettingsItemTextField: UITextField, TrackerSettingsItem {
    private let paddings = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    var editingChangedHandler: ((_ text: String?) -> Void)?
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        
        setPlaceholder(placeholder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        clearButtonMode = .whileEditing
        returnKeyType = .done
        autocorrectionType = .no
        
        textColor = .colorBlack
        font = .systemFont(ofSize: 17, weight: .regular)
        
        addTarget(
            self,
            action: #selector(primaryActionTriggered),
            for: .primaryActionTriggered
        )
        
        addTarget(
            self,
            action: #selector(editingChanged),
            for: .editingChanged
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: paddings)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if text?.isEmpty ?? true {
            return bounds.inset(by: paddings)
        }
        
        var correctPaddings = paddings
        
        correctPaddings.right += 28
        
        return bounds.inset(by: correctPaddings)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: paddings)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        super.clearButtonRect(forBounds: bounds).offsetBy(dx: -8, dy: 0)
    }
    
    @objc private func primaryActionTriggered() {
        resignFirstResponder()
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        editingChangedHandler?(textField.text)
    }
    
    private func setPlaceholder(_ text: String) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 17, weight: .regular),
                .foregroundColor: UIColor.colorGray
            ]
        )
    }
}
