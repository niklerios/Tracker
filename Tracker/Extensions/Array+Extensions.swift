//
//  Array+Extensions.swift
//  Tracker
//
//  Created by Nikler on 8/9/26.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
