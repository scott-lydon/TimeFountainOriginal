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
 */

extension Array where Element == Double {

}
