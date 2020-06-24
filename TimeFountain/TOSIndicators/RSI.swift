//
//  RSI.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array where Element == Double {
    
    /// The back of the array has the most recent prices. .
///    input length = 14;
///    input over_Bought = 70;
///    input over_Sold = 30;
///    input price = close;
///    input averageType = AverageType.WILDERS;
///    input showBreakoutSignals = no;
///
///    def NetChgAvg = MovingAverage(averageType, price - price[1], length);
///    def TotChgAvg = MovingAverage(averageType, AbsValue(price - price[1]), length);
///    def ChgRatio = if TotChgAvg != 0 then NetChgAvg / TotChgAvg else 0;
///
///    plot RSI = 50 * (ChgRatio + 1);
///    plot OverSold = over_Sold;
///    plot OverBought = over_Bought;
///    plot UpSignal = if RSI crosses above OverSold then OverSold else Double.NaN;
///    plot DownSignal = if RSI crosses below OverBought then OverBought else Double.NaN;
///
///    UpSignal.SetHiding(!showBreakoutSignals);
///    DownSignal.SetHiding(!showBreakoutSignals);
///
///    RSI.DefineColor("OverBought", GetColor(5));
///    RSI.DefineColor("Normal", GetColor(7));
///    RSI.DefineColor("OverSold", GetColor(1));
    /// first
    ///
    /// period = 14
    /// 1% average gain over period
    /// 0.8% average loss over period
    /// 55.55 = 100 - (100 / (1 + (1% / 0.8%)) )
    /// period = 14
    /// RSI2 = 100 - ( 100 / ( 1 + (prevousAverageGain * (period- 1)  + current gain) / (previousAverageLoss * (period - 1) + current loss  ) ))
    /// Should be used on an  arrray of gains.
    func rsis(length: Int = 2) -> [Double?] {
        var positiveSum: Double = 0
        var negativeSum: Double = 0
        var previousPositiveSum: Double = 0
        var previousNegativeSum: Double = 0
        return [nil] + enumerate { index, gain in
            positiveSum += gain.positiveOnly
            negativeSum += abs(gain.negativeOnly)
            if let earlyGain = self[safe: index - length] {
                let ret: Double = .rsi(
                    length, previousPositiveSum,
                    previousNegativeSum,
                    positiveSum,
                    negativeSum
                )
                previousPositiveSum = positiveSum
                previousNegativeSum = negativeSum
                positiveSum -= earlyGain.positiveOnly
                negativeSum -= abs(earlyGain.negativeOnly)
                return ret
            }
            return nil
        }
    }
    
    ///Will have a count one less of the current array's count, because a gain requires a comparison of two elements.
    var percentGains: [Double] {
        mapTwoIndex { first, second, index in
            (second - first) / first
        }
    }
}

extension Double {
    /// returns 0 if positive, current value if negative
    var negativeOnly: Double {
        self > 0 ? 0 : self
    }
    
    /// returns 0 if negative, self value if positive
    var positiveOnly: Double {
        self > 0 ? self : 0
    }
    
    /// RSI2 = 100 - ( 100 / ( 1 + (prevousAverageGain * (period- 1)  + current gain) / (previousAverageLoss * (period - 1) + current loss  ) ))
    /// 55.55 = 100 - (100 / (1 + (1% / 0.8%)) )
    static func rsi(
        _ length: Int,
        _ previousPositiveSum: Double = 0,
        _ previousNegativeSum: Double = 0,
        _ positiveSum: Double,
        _ negativeSum: Double
    ) -> Double {
        let lengthShort = Double(length - 1)
        let previousAverageGain = (previousPositiveSum / Double(length))
        let previousAverageLoss = (previousNegativeSum / Double(length))
        let positive = previousAverageGain * lengthShort + positiveSum
        let negative = previousAverageLoss * lengthShort + negativeSum
        return 100 - (100 / (1 + positive / negative))
    }
}
