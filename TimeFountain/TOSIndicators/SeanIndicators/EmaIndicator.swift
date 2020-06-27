//
//  EmaIndicator.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


///Usage:
///1. Candle Stick Interactions:
///    1. When the candlesticks break above the EMA it is a strong indicator of an upward trend.
///    2. When the candlesticks break below the EMA it is a strong indicator of a downward trend.
///2. Trend Confirmation:
///    1. Two candlesticks breaking above the EMA is a good double confirmation of a upward trend.
///        1. Could also be an indicator of a good time to buy.
///    2. Two candlesticks falling below the EMA is a good double confirmation of a downward trend.
///        1. Could also be an indicator of a good time to sell.
/// -  Strategy
///     We will flatten this enum.
enum EmaIndicator: String {
    ///  \   / close
    ///   *
    ///  /   \ ema
    case crossedAbove
    ///  \   / ema
    ///   *
    ///  /   \ close
    case crossedBelow
    ///    / close
    /// - *
    ///    \ ema
    case brokeAbove
    ///    / ema
    /// - *
    ///    \ close
    case brokeBelow
    /// ----close
    ///
    /// ---ema
    case isAbove
    /// ----ema
    ///
    /// ---close
    case isBelow
    ///
    /// ----ema/close
    ///
    case isOn
    /// close \
    ///      * ---
    /// ema /
    case pinchedFromAbove
    /// ema \
    ///      * ---
    /// close /
    case pinchedFromBelow
    
    
    init(_ candle1: Candle, _ ema: Double, _ candle2: Candle, ema2: Double) {
        if candle1.close > ema {
            if candle2.close > ema2 {
                self = .isAbove
            } else if candle2.close < ema2 {
                self = .crossedBelow
            } else {
                self = .pinchedFromAbove
            }
        } else if candle1.close < ema {
            if candle2.close > ema2 {
                self = .crossedAbove
            } else if candle2.close < ema2 {
                self = .isBelow
            } else {
                self = .pinchedFromBelow
            }
        } else {
            if candle2.close > ema2 {
                self = .brokeAbove
            } else if candle2.close < ema2 {
                self = .brokeBelow
            } else {
                self = .isOn
            }
        }
    }
}

extension Array where Element == Candle {
    
    var closes: [Double] {
        map {$0.close}
    }
    
    /// Self = Prices
    func breakOuts(for range: Int = 180, smoothing: Int = 2) -> [EmaIndicator?] {
        let emas = closes.emas(for: range, smoothing: smoothing)
        return [nil] + (1..<count).map {
            guard let candle1 = self[safe: $0 - 1],
                let ema1 = emas[safe: $0 - 1] as? Double,
                let candle2 = self[safe: $0],
                let ema2 = emas[safe: $0] as? Double else {
                    //emas will be nil at first so this is acceptable.
                    return nil
            }
            return EmaIndicator(candle1, ema1, candle2, ema2: ema2)
        }
    }
}
