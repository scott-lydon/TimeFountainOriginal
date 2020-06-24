//
//  Array+SupportResistance.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array where Element == Double {
    
    /// Self == prices
    ///1. Crossing Indicator
    ///    1. If EMA and SMA (180-Day) cross on an upward trend of stock price, it’s a strong confirmation of the stock continuing to trend upward.
    ///    2. If EMA and SMA (180-Day) cross on a downward trend of stock price, it’s a strong confirmation of the stock continuing to trend downward.
    func crosses(emas: [Double?], smas: [Double?]) -> [SMAEMACrossed?] {
        // assert(closes.count == emas.count && emas.count == smas.count)
        [nil] + (1..<count).map {
            guard let firstClose = self[safe: $0 - 1],
                let secondClose = self[safe: $0],
                let firstEma = emas[$0 - 1],
                let secondEma = emas[$0],
                let firstSMA = smas[$0 - 1],
                let secondSMA = smas[$0] else { return nil }
            return (firstEma > firstSMA) == (secondEma < secondSMA) ? .fromPrice(firstClose, secondClose) : nil
        }
    }
    
    /// Self == prices
    ///2. Support / Resistance Indicator
    ///    1. Above EMA line the SMA acts as a resistance.
    ///    2. Below the EMA line the SMA acts as a support.
    func supportResistancesEMASMA(emas: [Double?], smas: [Double?]) -> [EMASMASupportResistance?] {
        (0..<count).map {
            guard let ema = emas[$0], let sma = smas[$0] else { return nil }
            return EMASMASupportResistance(self[$0], ema, sma)
        }
    }
}
