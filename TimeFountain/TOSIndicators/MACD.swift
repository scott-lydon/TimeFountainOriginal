//
//  MACD.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

/*
 FUNC: MACD(12, 26, 9, EXPONENTIAL, yes)*
 fast length = 12
 slow length = 26
 macd length = 9
 average type = exponent
 show breakout signals = YES
 
 #
 # TD Ameritrade IP Company, Inc. (c) 2007-2020
 #

 declare lower;

 input fastLength = 12;
 input slowLength = 26;
 input MACDLength = 9;
 input averageType = AverageType.EXPONENTIAL;
 input showBreakoutSignals = no;

 plot Value = MovingAverage(averageType, close, fastLength) - MovingAverage(averageType, close, slowLength);
 plot Avg = MovingAverage(averageType, Value, MACDLength);

 plot Diff = Value - Avg;
 plot ZeroLine = 0;

 plot UpSignal = if Diff crosses above ZeroLine then ZeroLine else Double.NaN;
 plot DownSignal = if Diff crosses below ZeroLine then ZeroLine else Double.NaN;

 UpSignal.SetHiding(!showBreakoutSignals);
 DownSignal.SetHiding(!showBreakoutSignals);

 Value.SetDefaultColor(GetColor(1));
 Avg.SetDefaultColor(GetColor(8));
 Diff.SetDefaultColor(GetColor(5));
 Diff.SetPaintingStrategy(PaintingStrategy.HISTOGRAM);
 Diff.SetLineWeight(3);
 Diff.DefineColor("Positive and Up", Color.GREEN);
 Diff.DefineColor("Positive and Down", Color.DARK_GREEN);
 Diff.DefineColor("Negative and Down", Color.RED);
 Diff.DefineColor("Negative and Up", Color.DARK_RED);
 Diff.AssignValueColor(if Diff >= 0 then if Diff > Diff[1] then Diff.color("Positive and Up") else Diff.color("Positive and Down") else if Diff < Diff[1] then Diff.color("Negative and Down") else Diff.color("Negative and Up"));
 ZeroLine.SetDefaultColor(GetColor(0));
 UpSignal.SetDefaultColor(Color.UPTICK);
 UpSignal.SetPaintingStrategy(PaintingStrategy.ARROW_UP);
 DownSignal.SetDefaultColor(Color.DOWNTICK);
 DownSignal.SetPaintingStrategy(PaintingStrategy.ARROW_DOWN);
 */


extension Array where Element == Double {
    
    ///input fastLength = 12;
    ///input slowLength = 26;
    ///input MACDLength = 9;
    ///input averageType = AverageType.EXPONENTIAL;
    ///input showBreakoutSignals = no;
    ///
    ///plot Value = MovingAverage(averageType, close, fastLength) - MovingAverage(averageType, close, slowLength);
    ///plot Avg = MovingAverage(averageType, Value, MACDLength);
    ///
    ///plot Diff = Value - Avg;
    ///plot ZeroLine = 0;
    ///
    ///plot UpSignal = if Diff crosses above ZeroLine then ZeroLine else Double.NaN;
    ///plot DownSignal = if Diff crosses below ZeroLine then ZeroLine else Double.NaN;
    func macdDiffs(
        fast: Int = 12,
        slow: Int = 26,
        length: Int = 9,
        smoothing: Int = 2
    ) -> [Double?] {
        let fastemas = emas(for: fast, smoothing: smoothing)
        let slowemas = emas(for: slow, smoothing: smoothing)
        let valueMacds: [Double?] = (0..<count).map {
            guard let fast = fastemas[$0],
                let slow = slowemas[$0] else { return nil }
            return fast - slow
        }
        let avgs: [Double?] = valueMacds.filter { $0 == nil } + valueMacds.compactMap{$0}.emas(
            for: length,
            smoothing: smoothing
        )
        return (0..<count).map {
            guard let av = avgs[$0], let val = valueMacds[$0] else { return nil }
            return val - av
        }
    }
}
