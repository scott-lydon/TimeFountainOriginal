//
//  Resistance.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/25/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct ManualLine {
    var confirmations: [Point]
    let first: Point
    let last: Point
    /// How is the terminationPoint different from the last?
    var terminationPoint: Point?

    var count: Int {
        confirmations.count
    }
    
    var firstConfirmation: Point {
        confirmations[1]
    }

    init(
        first: Point,
        last: Point,
        pointsBetween: [Point] = [],
        terminationPoint: Point? = nil
    ) {
        self.first = first
        self.last = last
        self.confirmations = [first] + pointsBetween + [last]
        self.terminationPoint = terminationPoint
    }
    
    func value(at date: Date) -> Double {
        first.price + priceGap * date.timeIntervalSince1970 / dateGap
    }
    
    var priceGap: Double {
        last.price - first.price
    }
    
    var dateGap: Double {
        last.date.timeIntervalSince1970 - first.date.timeIntervalSince1970
    }
    
    func contains(_ date: Date) -> Bool {
        first.date...last.date ~= date
    }
}
