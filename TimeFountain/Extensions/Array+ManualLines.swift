//
//  Array+ManualLines.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/25/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array {
    
    typealias BeforeAndAfterBoolAction = (Element, Element, Element) -> Bool
    typealias BeforeAndAfterAction = (Element, Element, Element) -> Void
    
    /// Returns Elements that meet the given condition given the elements that come before and after.
    func beforeAndAfterElements(shouldAdd: BeforeAndAfterBoolAction) -> [Self.Element] {
        guard count > 2 else { return [] }
        var elements: [Element] = []
        for index in 1...(count - 2) {
            let before = index - 1
            let after = index + 1
            if shouldAdd(self[before], self[index], self[after]) {
                elements.append(self[index])
            }
        }
        return elements
    }
    
    /// Returns Elements that meet the given condition given the elements that come before and after.
    func beforeAndAfter(apply: BeforeAndAfterAction) {
        guard count > 2 else { return }
        for index in 1...(count - 2) {
            let before = index - 1
            let after = index + 1
            apply(self[before], self[index], self[after])
        }
    }
    
    typealias ElementBoolAction = (Element) -> Bool
    
    /// Removes elements from the current array returns the removes elements
    mutating func filterOut(where boolAction: ElementBoolAction) -> [Element] {
        var elements: Self = []
        var indices: [Int] = []
        for (index, element) in enumerated() {
            if boolAction(element) {
                indices.append(index)
                elements.append(element)
            }
        }
        for index in 0..<indices.count {
            remove(at: indices[indices.count - 1 - index])
        }
        return elements
    }
}
