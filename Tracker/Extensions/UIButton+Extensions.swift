//
//  UIButton+Extensions.swift
//  Tracker
//
//  Created by Nikler on 8/12/26.
//

import UIKit

extension UIButton {
    enum Style { case standard, customFill, customOutline }
    
    static let customHeight: CGFloat = 60
    
    convenience init(withStyle style: Style = .standard) {
        self.init(type: .custom)
        
        if case .standard = style {
            return
        }
        
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        if case .customFill = style {
            backgroundColor = .colorBlack

            setTitleColor(.colorWhite, for: .normal)
        }
        
        if case .customOutline = style {
            backgroundColor = .clear
            
            layer.borderWidth = 1
            layer.borderColor = UIColor.colorRed.cgColor

            setTitleColor(.colorRed, for: .normal)
        }
    }
}
