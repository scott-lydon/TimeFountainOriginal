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
        print(fromDate)
//        let second = Calendar.current.date(
//            byAdding: .day,
//            value: -10,
//            to: fromDate.
//        )
        let formerDate = Date(timeFromNow: hour * day * 25)
        print(formerDate ?? "Nil")
        let ticker = "TSLA"
        XCTAssertEqual(
            [
//                URL.priceHistory(
//                    period: .days(.ten, .oneMinute),
//                    endDate: <#T##Date?#>,
//                    startDate: <#T##Date?#>,
//                    ticker: ticker
//                )
            ],
            URL.priceHistories(ticker: ticker, dataFrameAction: { _ in})
        )
    }
}
