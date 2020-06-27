//
//  Array+ManualLine.Indicator.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/24/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array where Element == Point {
    
    var manualLineIndicators: [ManualLine.Indicator] {
        let lines: ManualLines = manualLines.sorted { $0.firstConfirmation.date < $1.firstConfirmation.date }
        var pointer = 0
        var relevantUnterminatedLines: ManualLines = []
        return enumerate { i, e in
            while lines[pointer].firstConfirmation.date < e.date {
                relevantUnterminatedLines.append(lines[pointer])
                pointer += 1
            }
            let indicator = ManualLine.Indicator(relevantUnterminatedLines)
            (0..<relevantUnterminatedLines.count).forEach {
                if let point = relevantUnterminatedLines[$0].terminationPoint, point.date < e.date {
                    relevantUnterminatedLines.remove(at: $0)
                }
            }
            return indicator
        }
    }
    
    var manualLines: [ManualLine] {
        var lines:[ManualLine] = []
        for (i,e) in self.enumerated() {
            /// https://towardsdatascience.com/programmatic-identification-of-support-resistance-trend-lines-with-python-d797a4a90530
        }
        return lines
    }
}

extension Array where Element == Point {
    
    /// Number of Points on a line and values for those line counts.
    typealias ConfirmationsPoints = [Int: [Double]]
    
    /// variance represents a percentage of the current variance, or a percentage of the indicator value.
    /// if the variance
    /// -  percent:   the high - low of the last n prices.
    ///             Should be in the format 1.03 etc.
    func manualLinesEntries(for percent: Double) -> [ManualLines.Entry] {
        
        var peaks: [Point] = []
        var unterminatedLines: [ManualLine] = []
        var terminatedLines: [ManualLine] = []
        var readouts: [ManualLines.Entry] = []
        let variance: Double = percent
        let range =  3000
        var frontRangePointer = 1
        var backRangePointer = 0
        
        beforeAndAfter { before, current, after in
            readouts.append(
                ManualLines.Entry(
                    current.date,
                    lines: unterminatedLines
                )
            )
            
            /// Finds a peak.  
            if before.price...after.price ~= current.price {
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

