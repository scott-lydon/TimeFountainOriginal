//
//  Line.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/23/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

typealias ManualLines = [ManualLine]

extension Array where Element == ManualLine {

    /// Why is this called an Entry? Shouldn't an entry be a manual line? Ambiguous
    /// Why are confirmation points relevant for a up and down entry? A date would seem to indicate an up and down line or a point in time...
    struct Entry {
        let date: Date
        
        /// - key: count of confirmations for a line
        /// - value: count of confirmations for the same line + value at the current date. 
        var confirmationPoints: [Int: [Double]]
        
        /// This Entry initializer assumes that once a resistance is passed it becomes a support, and when a support is past it becomes a resistance because it makes no distinction between a line that is above the price that was once a support and a resistance.
        init(_ date: Date, lines: [ManualLine]) {
            self.date = date
            self.confirmationPoints =  [:]
            for line in lines {
                var arr = confirmationPoints[line.confirmations.count] ?? []
                arr.append(line.value(at: date))
                confirmationPoints[line.confirmations.count] = arr
            }
        }
    }
}
