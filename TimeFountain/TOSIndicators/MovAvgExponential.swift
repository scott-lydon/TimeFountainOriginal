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
