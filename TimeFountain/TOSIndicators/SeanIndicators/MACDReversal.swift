//
//  MACDReversal.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

///Day Trading Usage:
///1. Trend Bars
///    1. When the MACD bars are green and start to flatline, and get smaller it’s usually an indicator that it’s most likely going on a downward trend.
///    1. When MACD bars are red and start to build a U formation it’s most likely going into a upward trend.
///        1. Additionally, when two similar length bars are right next to each other, it’s most likely going to bounce and potentially become a good buy.
extension MACDIntersection {
    
    /// Has the effect of representing the reversals and curvature.
    /// difference +-0
    /// difference2 +-0
    /// magdiff > magdiff2
    /// magdiff < magdiff2
    ///
    ///Irrelevant
    /// difference > difference2
    /// difference < difference2
    static func reversal(_ diff1: Double, _ diff2: Double, _ diff3: Double) -> MACDIntersection {
        let difference = diff2 - diff1
        let difference2 = diff3 - diff2
        return MACDIntersection(
            difference.mag,
            difference2.mag,
            Double.Magnitudey(
                compare: abs(difference),
                to: abs(difference2)
            )
        )
    }
}


extension Array where Element == Double {
    ///General Usage:
    ///1. Line Intersection [Reversals]
    ///    1. When the two MACD lines intersect with upswing, it is an indicator that the stock price will reverse up.
    ///    2. When the two MACD lines intersect with downswing, it is an indicator that the stock will reverse down.
    func macdReversals(
        fast: Int = 12,
        slow: Int = 26,
        length: Int = 9,
        smoothing: Int = 2
    ) -> [MACDIntersection?] {
        [nil, nil] + macdDiffs(
            fast: fast,
            slow: slow,
            length: length,
            smoothing: smoothing
        ).mapThree { diff1, diff2, diff3 in
            guard let dif1 = diff1,
                let dif2 = diff2,
                let dif3 = diff3 else { return nil }
            return MACDIntersection(dif1, dif2, dif3)
        }
    }
}
