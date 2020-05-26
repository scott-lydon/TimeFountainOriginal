//
//  SimpleMovingAverageTests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 5/25/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

import XCTest
@testable import TimeFountain

/*
 
 /// Work
SmaInOuts(
     prices: [3, 5, 1, 4],
     range: 2,
     values: [nil, 4, 3, 2.5]
 ),
 
 ___ | ____
 range  2
 self   [3, 5, 1, 4]
 smaSum  0, 3, 8
 index  0, 1
 value  3, 5
 early  -2, -1
 return [nil],
 */

/*
 
 /// REFERENCE from thinkscript
 SimpleMovingAvg(CLOSE, 180, 0, no)*
FUNC
 price: CLOSE
 length: 180
 
 input price = close;
 input length = 9;

 plot SMA = Average(price[-displace], length);
 plot UpSignal = price crosses above SMA;
 plot DownSignal = price crosses below SMA;

 
 */
class SimpleMovingTests: TimeFountainTests {
    
    struct SmaInOuts {
        var prices: [Double]
        var range: Int
        var values: [Double?]
    }
    
    // Takes an array of tick values (price, close, high, open)
    //  price: CLOSE
    //  length: 180
    var inputOutputs: [SmaInOuts] = [
        SmaInOuts(
            prices: [3, 5, 1, 4],
            range: 2,
            values: [nil, 4, 3, 2.5]
        ),
        SmaInOuts(
            prices: [3, 5, 1, 6],
            range: 3,
            values: [nil, nil, 3, 4]
        ),
        SmaInOuts(
            prices: [3,   5,    1,    4,  34, 1, 41, 8],
            range: 4,
            values: [nil, nil, nil, 3.25, 11, 10, 20, 21]
        ),
    ]
    
    func testSimpleMovingAverage() {
        inputOutputs.forEach {
            let test = $0.prices.sma(for: $0.range)
            let correct = $0.values
            XCTAssert(test == correct, "Failed when test: \(test) was not \(correct)")
        }
    }
}
