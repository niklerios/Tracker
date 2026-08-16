//
//  UsesAutoLayout.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

@propertyWrapper
struct UsesAutoLayout<T> {
    var wrappedValue: T
    
    init(wrappedValue: T) where T: UIView {
        self.wrappedValue = wrappedValue
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(wrappedValue: T) where T: Sequence, T.Element: UIView {
        self.wrappedValue = wrappedValue

        for view in wrappedValue {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
