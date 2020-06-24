//
//  VWAPIndicators.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

///Lines:
///1. Top VWAP - [Resistance] - a high price-point that the stock generally bounces at and reverses down.
///    1. Generally a good indicator of a time to sell
///    2.  Does not necessarily need to touch the line to be a confirmation.
///2. Bottom VWAP - [Support] - A low-price point that the stock generally bounces at and reverses up.
///3. Middle VWAP
///    1. Indicator that the stock is on an uptrend is when it’s trading price is between Middle VWAP and Top VWAP
///    2. Indicator that the stock is on an downtrend is when it’s trading price is between the Middle VWAP and the Bottom VWAP


extension Array where Element == Double {
    
    func simpleVwapIndicators(vwaps: [Double?]) -> [MACDIntersection?] {
        [nil, nil] + (2..<count).map {
            guard let firstVWAP = vwaps[$0 - 2], let secondVWAP = vwaps[$0 - 1], let thirdVWAP = vwaps[$0] else { return nil }
            return MACDIntersection.simpleVWAP(
                firstVWAP: firstVWAP,
                firstClose: self[$0 - 2],
                secondVWAP: secondVWAP,
                secondClose: self[$0 - 1],
                thirdVWAP: thirdVWAP,
                thirdClose: self[$0]
            )
        }
    }
}

extension MACDIntersection {
    
    static func simpleVWAP(
        firstVWAP: Double,
        firstClose: Double,
        secondVWAP: Double,
        secondClose: Double,
        thirdVWAP: Double,
        thirdClose: Double
    ) -> Self {
        MACDIntersection(
            Double.Magnitudey(compare: firstClose, to: firstVWAP),
            Double.Magnitudey(compare: secondClose, to: secondVWAP),
            Double.Magnitudey(compare: thirdClose, to: thirdVWAP)
        )
    }
}

enum VWAPIndicator {
    case ontrainwreck
    case underTrainWreck
    case aboveTrainWreck
    case farAboveTop
    case justAboveTop
    case onTop
    case justBelowTop
    case justAboveMid
    case onMid
    case justBelowMid
    case justAboveBottom
    case justBelowBottom
    case farBelowBottom
}

///MATHEMATICALLY REDUNDANT, bad Sean....   :)
///4. EMA Interactions:
///    1. If a stock breaks above the EMA and the middle VWAP this is an indication of an uptrend.
///    2. If a stock breaks below the EMA and middle VWAP, it’s likely an indication of a downtrend or a selloff.
///5. RSI Interactions:
///    1. Utilize the RSI indicator as an additional confirmation of a sell off or a reversal.
///        1.  High/Red RSI  Indicates the stock is overpriced, and will likely Sell Off
///        2. Low/Blue RSI indicates the stock is underpriced and will likely be a good buy.
///6. MACD Interactions:
///    1. Utilize the MACD indicator for additional signs of a reversal on the stock, either up or down (Lines Crossing)
