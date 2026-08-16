//
//  Array+Extensions.swift
//  Tracker
//
//  Created by Nikler on 8/9/26.
//

extension Array {
    subscript(safe index: Int, default defaultElement: Element? = nil) -> Element? {
        indices ~= index ? self[index] : defaultElement
    }
    
    subscript(safe index: Int, default defaultElement: Element) -> Element {
        self[safe: index] ?? defaultElement
    }
}
