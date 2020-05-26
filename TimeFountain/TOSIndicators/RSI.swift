//
//  RSI.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

/*
 RSI(14, 70, 30, CLOSE, WILDERS, no)* 
 length = 14
 over bought = 70
 over sold = 30
 price = CLOSE
 average type = wilders
 show breakout signals = NO
 
 
 #
 # TD Ameritrade IP Company, Inc. (c) 2007-2020
 #

 declare lower;

 input length = 14;
 input over_Bought = 70;
 input over_Sold = 30;
 input price = close;
 input averageType = AverageType.WILDERS;
 input showBreakoutSignals = no;

 def NetChgAvg = MovingAverage(averageType, price - price[1], length);
 def TotChgAvg = MovingAverage(averageType, AbsValue(price - price[1]), length);
 def ChgRatio = if TotChgAvg != 0 then NetChgAvg / TotChgAvg else 0;

 plot RSI = 50 * (ChgRatio + 1);
 plot OverSold = over_Sold;
 plot OverBought = over_Bought;
 plot UpSignal = if RSI crosses above OverSold then OverSold else Double.NaN;
 plot DownSignal = if RSI crosses below OverBought then OverBought else Double.NaN;

 UpSignal.SetHiding(!showBreakoutSignals);
 DownSignal.SetHiding(!showBreakoutSignals);

 RSI.DefineColor("OverBought", GetColor(5));
 RSI.DefineColor("Normal", GetColor(7));
 RSI.DefineColor("OverSold", GetColor(1));
 RSI.AssignValueColor(if RSI > over_Bought then RSI.color("OverBought") else if RSI < over_Sold then RSI.color("OverSold") else RSI.color("Normal"));
 OverSold.SetDefaultColor(GetColor(8));
 OverBought.SetDefaultColor(GetColor(8));
 UpSignal.SetDefaultColor(Color.UPTICK);
 UpSignal.SetPaintingStrategy(PaintingStrategy.ARROW_UP);
 DownSignal.SetDefaultColor(Color.DOWNTICK);
 DownSignal.SetPaintingStrategy(PaintingStrategy.ARROW_DOWN);
 */
