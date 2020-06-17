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
    
    func testURLS() {
        let recentDate = Date()
        let hour = 60
        let day = 24
        guard let fromDate = Calendar.current.date(
            byAdding: .day,
            value: -10,
            to: recentDate
            ) else { return }
//        let second = Calendar.current.date(
//            byAdding: .day,
//            value: -10,
//            to: fromDate.
//        )
        let formerDate = Date(timeFromNow: hour * day * 25)
        
        let ticker = "TSLA"
        XCTAssertEqual(
            [
                URL.priceHistory(
                    period: .days(.ten, .oneMinute),
                    endDate: <#T##Date?#>,
                    startDate: <#T##Date?#>,
                    ticker: ticker
                )
            ],
            URL.priceHistories(ticker: ticker, dataFrameAction: { _ in})
        )
    }
    
}
/*
 enum Period {
     case days(DayCount, Minute)
     case months(MonthCount, DailyWeekly)
     case years(YearCount, DailyWeeklyMonthly)
     case ytd(DailyWeekly)
     
     func dates(from: Date, to: Date) -> [Date] {
         
         switch self {
         case .days(let dayCount, _):
             do {}
         case .months(let monthCount, _):
             do {}
         case .years(let yearCount, _):
             do {}
         case .ytd(_):
             do {}
         }
         return []
     }
 
 */

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
