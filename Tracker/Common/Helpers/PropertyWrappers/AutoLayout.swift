//
//  AutoLayout.swift
//  Tracker
//
//  Created by Nikler on 6/26/26.
//

import UIKit

@propertyWrapper
struct AutoLayout<T: UIView> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
