//
//  EmaSupportResistance.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

///Definition: An exponential moving average (EMA) is a type of moving average (MA) that places a greater weight and significance on the most recent data points. An exponentially weighted moving average reacts more significantly to recent price changes than a simple moving average (SMA), which applies an equal weight to all observations in the period.
///
///Usage:
///1. Candle Stick Interactions:
///    1. When the candlesticks break above the EMA it is a strong indicator of an upward trend.
///    2. When the candlesticks break below the EMA it is a strong indicator of a downward trend.
///2. Trend Confirmation:
///    1. Two candlesticks breaking above the EMA is a good double confirmation of a upward trend.
///        1. Could also be an indicator of a good time to buy.
///    2. Two candlesticks falling below the EMA is a good double confirmation of a downward trend.
///        1. Could also be an indicator of a good time to sell.

/// Nearness lines are based on 20% not 30%
enum EMASMASupportResistance {
    ///   *
    /// - - -
    ///
    /// ema ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// sma ----
    case farAboveSupportAndEma
    ///
    /// - - -
    ///   *
    /// ema ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// sma ----
    case aboveSupportAndEma
    ///
    /// - - -
    ///
    /// ema ---
    ///   *
    /// - - -
    ///
    /// - - -
    ///
    /// sma ----
    case aboveSupportJustBelowEma
    ///
    /// - - -
    ///
    /// ema ---
    ///
    /// - - -
    ///   *
    /// - - -
    ///
    /// sma ----
    case betweenSupportAndEma
    ///
    /// - - -
    ///
    /// ema ---
    ///
    /// - - -
    ///
    /// - - -
    ///   *
    /// sma ----
    case justAboveSupport
    ///
    /// - - -
    ///
    /// ema ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// sma --*
    case onSupport
    ///
    /// - - -
    ///
    /// ema ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// sma ----
    ///  *
    case underSupport
    ///
    /// - - -
    ///
    /// ema ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// sma ----
    ///
    ///  - - -
    ///  *
    case farUnderSupport
    ///   *
    /// - - -
    ///
    /// sma ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// ema ----
    case farAboveResistance
    ///
    /// - - -
    ///   *
    /// sma ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// ema ----
    case justAboveResistance
    ///
    /// - - -
    ///
    /// sma --*
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// ema ----
    case onResistance
    ///
    /// - - -
    ///
    /// sma ---
    ///   *
    /// - - -
    ///
    /// - - -
    ///
    /// ema ----
    case justUnderResistance
    ///
    /// - - -
    ///
    /// sma ---
    ///
    /// - - -
    ///   *
    /// - - -
    ///
    /// ema ----
    case betweenResistanceAndEma
    ///
    /// - - -
    ///
    /// sma ---
    ///
    /// - - -
    ///
    /// - - -
    ///   *
    /// ema ----
    case belowResistanceJustAboveEma
    ///
    /// - - -
    ///
    /// sma ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// ema --*
    case belowResistanceOnEma
    ///
    /// - - -
    ///
    /// sma ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// ema ----
    ///  *
    case belowResistanceBelowEma
    ///
    /// - - -
    ///
    /// sma ---
    ///
    /// - - -
    ///
    /// - - -
    ///
    /// ema ----
    ///
    ///  - - -
    ///  *
    case belowResistanceAndFarBelowEma
    ///  *
    /// emasma---
    ///
    case aboveCross
    ///
    /// emasma---*
    ///
    case onCross
    ///
    /// emasma---
    /// *
    case underCross
    
    init(_ close: Double, _ ema: Double, _ sma: Double) {
        let twentyPercent = abs(ema - sma) * 0.2
        let twentyAboveSMA = sma + twentyPercent
        let twentyBelowSMA = sma - twentyPercent
        let twentyAboveEma = ema + twentyPercent
        let twentyBelowEma = ema - twentyPercent
        if ema > sma {
            if close > twentyAboveEma {
                self = .farAboveSupportAndEma
            } else if ema...twentyBelowEma ~= close {
                self = .aboveSupportAndEma
            } else if twentyBelowEma...ema ~= close {
                self = .aboveSupportJustBelowEma
            } else if twentyAboveSMA...twentyBelowEma ~= close {
                self = .betweenSupportAndEma
            } else if sma...twentyAboveSMA ~= close {
                self = .justAboveSupport
            } else if twentyBelowSMA...sma ~= close {
                self = .underSupport
            } else  {
                self = .farUnderSupport
            }
        } else if ema < sma {
            if close > twentyAboveSMA {
                self = .farAboveResistance
            } else if sma...twentyAboveSMA ~= close {
                self = .justAboveResistance
            } else if twentyBelowSMA...sma ~= close {
                self = .justUnderResistance
            } else if twentyAboveEma...twentyBelowSMA ~= close {
                self = .betweenResistanceAndEma
            } else if ema...twentyAboveEma ~= close {
                self = .belowResistanceJustAboveEma
            } else if ema == close {
                self = .belowResistanceOnEma
            } else if twentyBelowEma...ema ~= close {
                self = .belowResistanceBelowEma
            } else  {
                self = .belowResistanceAndFarBelowEma
            }
        } else {
            if close > ema {
                self = .aboveCross
            } else if close < ema {
                self = .underCross
            } else {
                self = .onCross
            }
        }
    }
}
