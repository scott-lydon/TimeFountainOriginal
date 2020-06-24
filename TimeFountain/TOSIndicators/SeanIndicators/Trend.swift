//
//  Trend.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

enum Trend {
    case up
    case down
    case level
    
    init(_ candle1: Candle, _ candle2: Candle) {
        if candle1.average > candle2.average {
            self = .down
        } else if candle1.average < candle2.average {
            self = .up
        } else {
            self = .level
        }
    }
}

extension Candle {
    var average: Double {
        (close + candleOpen + high + low) / 4
    }
}

extension Array where Element == Candle {
    
    var trends: [Trend?] {
        [nil] + (1..<count).map {
            Trend(self[$0 - 1], self[$0])
        }
    }
}
