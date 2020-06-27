//
//  VWAP.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


/*
 
 FUNC: VWAP(-2.0, 2.0, DAY)*
 num dev dn: -2.0
 num dev up: 2.0
 time frame: DAY
 
 #
 # TD Ameritrade IP Company, Inc. (c) 2011-2020
 #

 input numDevDn = -2.0;
 input numDevUp = 2.0;
 input timeFrame = {default DAY, WEEK, MONTH};

 def cap = getAggregationPeriod();
 def errorInAggregation =
     timeFrame == timeFrame.DAY and cap >= AggregationPeriod.WEEK or
     timeFrame == timeFrame.WEEK and cap >= AggregationPeriod.MONTH;
 assert(!errorInAggregation, "timeFrame should be not less than current chart aggregation period");

 def yyyyMmDd = getYyyyMmDd();
 def periodIndx;
 switch (timeFrame) {
 case DAY:
     periodIndx = yyyyMmDd;
 case WEEK:
     periodIndx = Floor((daysFromDate(first(yyyyMmDd)) + getDayOfWeek(first(yyyyMmDd))) / 7);
 case MONTH:
     periodIndx = roundDown(yyyyMmDd / 100, 0);
 }
 def isPeriodRolled = compoundValue(1, periodIndx != periodIndx[1], yes);

 def volumeSum;
 def volumeVwapSum;
 def volumeVwap2Sum;

 if (isPeriodRolled) {
     volumeSum = volume;
     volumeVwapSum = volume * vwap;
     volumeVwap2Sum = volume * Sqr(vwap);
 } else {
     volumeSum = compoundValue(1, volumeSum[1] + volume, volume);
     volumeVwapSum = compoundValue(1, volumeVwapSum[1] + volume * vwap, volume * vwap);
     volumeVwap2Sum = compoundValue(1, volumeVwap2Sum[1] + volume * Sqr(vwap), volume * Sqr(vwap));
 }
 def price = volumeVwapSum / volumeSum;
 def deviation = Sqrt(Max(volumeVwap2Sum / volumeSum - Sqr(price), 0));
 
 plot VWAP = price;
 plot UpperBand = price + numDevUp * deviation;
 plot LowerBand = price + numDevDn * deviation;
 
 */
struct VWAP {
    var upper: Double
    var middle: Double
    var lower: Double
}

typealias SimpleVWAP = MACDIntersection

extension Array where Element == Candle {
    
    /// - Parameters
    ///     - range: The default value is 180, a guess to line up with sma and ema defaults.
    ///     - vwaps: volume weighted average.
    func simpleVwapIndicators(range: Int = 180) -> [SimpleVWAP?] {
        let closes: [Double] = self.closes
        let vwaps = self.vwaps(range)
        return [nil, nil] + (2..<count).map {
            guard let firstVWAP = vwaps[$0 - 2], let secondVWAP = vwaps[$0 - 1], let thirdVWAP = vwaps[$0] else { return nil }
            return MACDIntersection.simpleVWAP(
                firstVWAP: firstVWAP,
                firstClose: closes[$0 - 2],
                secondVWAP: secondVWAP,
                secondClose: closes[$0 - 1],
                thirdVWAP: thirdVWAP,
                thirdClose: closes[$0]
            )
        }
    }
    
///    Find the average price the stock traded at over the first five-minute period of the day. To do this, add the high, low, and close, then divide by three. Multiply this by the volume for that period. Record the result in a spreadsheet, under column PV.
///    Divide PV by the volume for that period. This will give the VWAP value.
///    To maintain the VWAP value throughout the day, continue to add the PV value from each period to the prior values. Divide this total by total volume up to that point. To make this easier in a spreadsheet, create columns for cumulative PV and cumulative volume. Both these cumulative values are divided by each other to produce VWAP.
    ///
    /// 100 * 10, 8 * 300, 11 * 200 / 100 + 300 + 200 = 9.33
    ///
    func vwaps(_ range: Int = 180) -> [Double?] {
        var numeratorSum: Double = 0
        var volumes: Double = 0
        return enumerate { index, candle in
            numeratorSum += candle.volume * candle.close
            volumes += candle.volume
            if let early = self[safe: index - range] {
                numeratorSum -= early.volume * candle.close
                volumes -= early.volume
                return numeratorSum / volumes
            } else {
                return nil
            }
        }
    }
    
//    func vwaps(_ range: Int, devup: Double = 2, devdown: Double = 2) -> [VWAP?] {
//        var numeratorSum: Double = 0
//        var volumes: Double = 0
//        return enumerate { index, candle in
//            numeratorSum += candle.volume * candle.close
//            volumes += candle.volume
//            if let early = self[safe: index - range] {
//                numeratorSum -= early.volume * candle.close
//                volumes -= early.volume
//                let vwap: Double = numeratorSum / volumes
//                let volumeSum = candle.volume
//                let volumeVwapSum = candle.volume * vwap
//                let volumeVwap2Sum = candle.volume * sqrt(vwap)
//                let deviation: Double = sqrt(max(<#T##x: Comparable##Comparable#>, 0))
//                return VWAP(
//                    upper: vwap + devup * ,
//                    middle: vwap,
//                    lower: vwap + devdown
//                )
//            } else {
//                return nil
//            }
//        }
//    }
}

