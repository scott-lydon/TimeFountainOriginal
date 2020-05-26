//
//  Angle.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/25/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Angle: Comparable {
    static func < (lhs: Angle, rhs: Angle) -> Bool {
        lhs.value < rhs.value
    }
    
    static func == (lhs: Angle, rhs: Angle) -> Bool {
        lhs.value == rhs.value
    }
    
    var fromPoint: Point
    var value: Double
    
    func height(for date: Date?) -> Double {
        guard let date = date else { return 0 }
        //   opposite
        //  ----
        //   \ |  adjacent
        //    \|
        //     *
        //   < Angle ^ (270 + degrees)
        //  tan(360 - angle) = opposite / adjacent
        //  adjacent = opposite / tan(360 - angle)
        let opposite = -(date.timeIntervalSince1970 - fromPoint.date.timeIntervalSince1970)
        let adjacent = opposite / tan(360 - value)
        return  adjacent + fromPoint.price
        
    }
    
    
    init(from: Point, to: Point) {
        self.fromPoint = from
        let absRise = abs(from.price - to.price)
        let absRun = abs(from.date.timeIntervalSince1970 - to.date.timeIntervalSince1970 )
        if from.date.timeIntervalSince1970 < to.date.timeIntervalSince1970 {
            if from.price < to.price  {
                //  ___
                //  | /    opposite = run, adjacent = rise
                //  *     tan(angle) = opposite / adjacent
                // angle = atan(opposite / adjacent)
                self.value = atan(absRun / absRise)
            } else {
                //  | 90degrees
                //  *_
                //   \|     adjacent = run, opposite = rise
                //          tan(angle) = opposite / adjacent
                //          angle = atan(opposite / adjacent)
                self.value = 90 + atan(absRise / absRun)
            }
        } else {
            if from.price > to.price {
                //    | 180degrees
                //    *
                //   /|     adjacent = rise, opposite = run
                //   -      tan(angle) = opposite / adjacent
                //          angle = atan(opposite / adjacent)
                self.value = 180 + atan(absRun / absRise)
            } else {
                //  |\ |
                //  |_\| 270degrees
                //     *
                //          adjacent = run, opposite = rise
                //          tan(angle) = opposite / adjacent
                //          angle = atan(opposite / adjacent)
                self.value = 180 + atan(absRise / absRun)
            }
        }
    }
}



