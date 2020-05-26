//
//  Array+Point.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/25/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


extension Array where Element == Point {
    
    /// Number of Points on a line and values for those line counts.
    typealias ConfirmationsPoints = [Int: [Double]]
    
    /// variance represents a percentage of the current variance, or a percentage of the indicator value.
    /// if the variance
    func manualLinesEntries(for percent: Double) -> [ManualLinesEntry] {
        
        var peaks: [Point] = []
        var unterminatedLines: [Resistance] = []
        var terminatedLines: [Resistance] = []
        var readouts: [ManualLinesEntry] = []
        
        /// the high - low of the last n prices.
        /// Should be in the format 1.03 etc.
        let variance: Double = percent
        let range =  3000
        var frontRangePointer = 1
        var backRangePointer = 0
        
        self.beforeAndAfter { before, current, after in
            readouts.append(
                ManualLinesEntry(
                    current.date,
                    lines: unterminatedLines
                )
            )
            if current.price.isBetween(before.price, after.price) {
                peaks.append(current)
                unterminatedLines.addNewLines(
                    from: current,
                    and: peaks,
                    since: self[backRangePointer].date,
                    variance: variance
                )
            }
            terminatedLines.append(
                contentsOf: unterminatedLines.terminated(
                    by: current,
                    and: variance * current.price
                )
            )
            frontRangePointer += 1
            if frontRangePointer > backRangePointer + range {
                backRangePointer += 1
            }
        }
        return readouts
    }
}
