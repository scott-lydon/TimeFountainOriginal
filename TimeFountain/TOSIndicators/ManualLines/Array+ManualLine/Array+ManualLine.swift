//
//  Array+Resistance.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/25/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array where Element == ManualLine {
    
    mutating func addNewLines(
        from point: Point,
        and peaks: [Point],
        since: Date,
        variance: Double,
        maxHeightInRange maxHeight: Double? = nil
    ) {
        // Check if should be added to a prior line
        for index in 0..<count {
            if abs(self[index].value(at: point.date) - point.price) < variance {
                self[index].confirmations.append(point)
                return
            }
        }
        var lines: [ManualLine] = []
        var angle = ManualLine.Angle(from: point, to: peaks[peaks.count - 1])
        var pointer = peaks.count - 2
        
        ///TODO:  update + var as needed. 
        let requisiteHeight = angle.height(for: peaks.last?.date)
        
        while pointer >= 0 {
            let newAngle = ManualLine.Angle(from: point, to: peaks[pointer])
            guard let max = maxHeight else {
                pointer -= 1
                continue
            }
            if angle < newAngle && requisiteHeight < max {
                angle = newAngle
                lines.append(ManualLine(first: peaks[pointer], last: point))
            }
            pointer -= 1
        }
    }

    
    /// variance represents either a percentage of the line's value, or a percent of the current time frame's variance.
    /// Removes and returns terminated lines.
    mutating func terminated(by point: Point, and variance: Double) -> [ManualLine] {
        filterOut { point.price > $0.value(at: point.date) + variance }
    }
}
