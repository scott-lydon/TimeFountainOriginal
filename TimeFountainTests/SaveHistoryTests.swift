//
//  SaveHistoryTests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/11/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain
import Alamofire

extension TimeFountainTests {
    
    func testCandleInit() {
        var candles = CandleList(symbol: "TSLA")
        XCTAssert(candles.empty)
        XCTAssert(candles.candles.isEmpty)
        candles.candles.append(
            Candle(
                close: 12.1,
                datetime: 12.1,
                high: 12.1,
                low: 12.1,
                candleOpen: 12.1,
                volume: 12.1
            )
        )
        XCTAssert(!candles.candles.isEmpty)
    }
    
    func testTDAmeritradeRepetition() {
        let num = 3
        var counter = 0
        DispatchQueue.tdAPI(repeats: num) { int in
            counter += 1
        }
       /// XCTAssert(<#T##expression: Bool##Bool#>)
    }
    
}

/*
 /// back represents the number of 10 day units back we are getting the data for.
 func saveHistory(for tickers: [String], back: Int) {
     tickers.forEach { ticker in
         var allCandles = CandleList(
             candles: [],
             empty: true,
             symbol: ticker
         )
         (0...back).forEach { int in
             // TD Ameritrade allows 120 calls a minute
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                 let mins = 10 * 24 * 60
                 URL.priceHistory(
                     period: .days(.ten, .oneMinute),
                     endDate: Date(timeFromNow: int * mins),
                     startDate: Date(timeFromNow: (int + 1) * mins),
                     ticker: ticker
                 ).getData { data in
                     guard let candles = CandleList(data) else { return }
                     allCandles.candles.append(contentsOf: candles.candles)
                 }
             }
         }
         allCandles.candles.sort { $0.datetime > $1.datetime }
         guard let dataframe = DataFrame(
                 DataFrame.Column(
                     header: "date",
                     cells: allCandles.dates.asStrings
                 ),
                 DataFrame.Column(
                     header: "close",
                     cells: allCandles.closes.asStrings
                 ),
                 DataFrame.Column(
                     header: "SMA",
                     cells: allCandles.closes.sma(for: 180).asStrings
                 )
             ) else { return }
         let csv = dataframe.convertToCSV(
             root: .desktopDirectory,
             named: ticker + "_" + Date().timeIntervalSince1970.string
         )
         print(csv?.absoluteString ?? "nil")
     }
 }
 
 */
