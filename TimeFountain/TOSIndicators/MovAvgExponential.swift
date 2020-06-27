//
//  MovAvgExponential.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


/*
 FUNC MovAvgExponential(CLOSE, 9, 0, no)*
    price = CLOSE
    length = 0
    displace = 0
    how breakout signals = No
 
 #
 # TD Ameritrade IP Company, Inc. (c) 2017-2020
 #

 input price = close;
 input length = 9;
 input displace = 0;
 input showBreakoutSignals = no;

 plot AvgExp = ExpAverage(price[-displace], length);
 plot UpSignal = price crosses above AvgExp;
 plot DownSignal = price crosses below AvgExp;

 UpSignal.SetHiding(!showBreakoutSignals);
 DownSignal.SetHiding(!showBreakoutSignals);

 AvgExp.SetDefaultColor(GetColor(1));
 UpSignal.SetDefaultColor(Color.UPTICK);
 UpSignal.SetPaintingStrategy(PaintingStrategy.BOOLEAN_ARROW_UP);
 DownSignal.SetDefaultColor(Color.DOWNTICK);
 DownSignal.SetPaintingStrategy(PaintingStrategy.BOOLEAN_ARROW_DOWN);
 */



extension Array where Element == Double {
    /**  The exponential moving average (EMA) is a technical chart indicator that tracks the price of an investment (like a stock or commodity) over time. The EMA is a type of weighted moving average (WMA) that gives more weighting or importance to recent price data. Like the simple moving average, the exponential moving average is used to see price trends over time, and watching several EMAs at the same time is easy to do with moving average ribbons.
    - Parameter
        - range: How far back to make the moving average.
        - smoothing:  If the smoothing factor is increased, more recent observations have more influence
    EMA=Price(t)×k+EMA(y)×(1−k)
    where:
    t=today
    y=yesterday
    N=number of days in EMA
    k=2÷(N+1)
    
      Given an array of prices
     */
    func emas(for range: Int = 180, smoothing: Int = 2) -> [Double?] {
        var ema: Double?
        let multiplier: Double = Double(smoothing) / (Double(range) + 1)
        return (0..<count).map {
            if let last = ema {
                //Sean?
                //ema = last * multiplier + self[$0] * (1 - multiplier)
                //THEbalance
                //ema = (self[$0] - last) * multiplier + last
                // Investopedia
                ema = self[$0] * multiplier + last * (1 - multiplier)
            } else {
                ema = sma(for: range)[$0]
            }
            return ema
        }
    }
}
