//
//  RSIIndicator.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

///Usage:
///1. RSI indicator closer to 30 and/or Blue indicates a stock is oversold, and therefore underpriced potentially indicating a good buy
///2. RSI indicator closer to 60 and/or Red indicates a stock is overbought  and therefore overpriced and potentially indicating a bad buy
enum RSIPercentile: String {
    case belowZero, lowerTen, lowerTwenty, lowerThirty, lowerForty, lowerFifty, upperFifty, upperSixty, upperSeventy, upperEighty, upperNinety, above100
    
    init(rsi: Double) {
        if rsi < 0 {
            self = .belowZero
        } else if 0...10 ~= rsi {
            self = .lowerTen
        } else if 10...20 ~= rsi {
            self = .lowerTwenty
        } else if 20...30 ~= rsi {
            self = .lowerThirty
        } else if 30...40 ~= rsi {
            self = .lowerForty
        } else if 40...50 ~= rsi {
            self = .lowerFifty
        } else if 50...60 ~= rsi {
            self = .upperFifty
        } else if 60...70 ~= rsi {
            self = .upperSixty
        } else if 70...80 ~= rsi {
            self = .upperSeventy
        } else if 80...90 ~= rsi {
            self = .upperEighty
        } else if 90...100 ~= rsi {
            self = .upperNinety
        } else {
            print("WARNING: RSI is above 100%")
            self = .above100
        }
    }
}


extension Array where Element == Double {
    
    func risIndicators(length: Int) -> [RSIPercentile?] {
        rsis(length: length).map {
            guard let rsi = $0 else { return nil }
            return RSIPercentile(rsi: rsi)
        }
    }
}
