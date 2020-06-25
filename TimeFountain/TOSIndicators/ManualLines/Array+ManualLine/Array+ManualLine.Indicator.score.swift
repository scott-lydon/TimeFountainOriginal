//
//  Array+ManualLine.Indicator.score.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/24/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

/// A point will have an array of manual line indicators.
extension Array where Element == ManualLine.Indicator {
    
    /// A point will have an array of 0 or more manual line indicators.
    /// This is an summary indicator of those manual line indicators for the given point.
    var comprehensiveIndicator: String {
        map { $0.name }.sorted().joined(separator: "_")
    }
    
    var score: Double {
        sum {
            Double($0.confirmationCount * $0.trend.rawValue)
        }
    }
    
    /// This Takes an indicators array's score per point and converts it to an enum
    /// - max: maximum manual line indicator array score so far for prices.
    /// - min: minimum manual line indicator array score so far for prices.
    func percent(max: Double, min: Double) -> Percent {
        Percent(score: score, min: min, max: max)
    }
    
    /// This Takes an indicators array's score per point and converts it to an enum
    /// - max: maximum manual line indicator array score so far for prices.
    /// - min: minimum manual line indicator array score so far for prices.
    func simpleSignedPercent(max: Double, min: Double) -> SimplePercent {
        SimplePercent(score: score, min: min, max: max)
    }
}
