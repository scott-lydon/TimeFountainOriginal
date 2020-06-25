//
//  Array+Int.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    var allEqual: Bool {
        guard count >= 2, let first = first else { return true }
        return allSatisfy { $0 == first }
    }
}

extension Array {
    
    func sum<Generic: AdditiveArithmetic>(of action: (Element) -> Generic) -> Generic {
        var sum: Generic = .zero
        for element in self {
           sum += action(element)
        }
        return sum
    }
}


extension Array {
    
    func mapTwo<Generic>(_ map3Action: (Element, Element) -> Generic?) -> [Generic?] {
        guard count > 1 else { return [] }
        return (1..<count).map {
            map3Action(self[$0 - 1], self[$0])
        }
    }
    
    func mapThree<Generic>(_ map3Action: (Element, Element, Element) -> Generic?) -> [Generic?] {
        guard count > 2 else { return [] }
        return (2..<count).map {
            map3Action(self[$0 - 2], self[$0 - 1], self[$0])
        }
    }
    
    typealias MapTwoIndexType = (Element, Element, Int) -> Element
    func mapTwoIndex(_ mapTwoIndex: MapTwoIndexType) -> [Element] {
        (1..<count).map {
            mapTwoIndex(self[$0 - 1], self[$0], $0)
        }
    }
    
    typealias MapIndexType = (Int, Element) -> Element
    @discardableResult
    func enumerate(_ mapIndex: MapIndexType) -> [Element] {
        (0..<count).map {
            mapIndex($0, self[$0])
        }
    }
}
