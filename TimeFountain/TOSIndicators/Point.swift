//
//  Point.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/24/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


struct Point: Comparable {
    
    static func < (lhs: Point, rhs: Point) -> Bool {
        lhs.date < rhs.date
    }
    
    var price: Double
    var date: Date

    /// Returns nil when the date of this point is outside the bounds of the line.
    /// Returns positive then the point is above the line.
    /// Returns negative when the point is below the line.
    func relation(to line: ManualLine) -> Double? {
        guard line.contains(date) else { return nil }
        return price - line.value(at: date)
    }
}
