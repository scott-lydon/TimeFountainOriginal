//
//  SimpleMovingAvg.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array where Element == Double {
    /// Excludes current value in calculating the average, because it is used to determine when the current value deviates from the average, so it doesn't make sense for it to biase the average.
    /// Default is false because I think that is what tos does.
    func sma(for range: Int, excludesCurrent: Bool = false) -> [Double?] {
        var smaSum = 0.0
        var smas: [Double?] = []
        for (index, value) in self.enumerated() {
            smaSum += value
            let early = index - range + 1
            if early >= 0 {
                smas.append(smaSum / Double(range))
                smaSum -= self[early]
            } else {
                smas.append(nil)
            }
        }
        return smas
    }
    
    var asStrings: [String] {
        map { $0.description }
    }
}

extension Array where Element == Double? {
    var asStrings: [String] {
        map { $0?.description ?? "nil" }
    }
}
