//
//  Underlying.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Underlying: Codable {
    let ask, askSize, bid, bidSize: Int
    let change, close: Int
    let delayed: Bool
    let underlyingDescription, exchangeName: String
    let fiftyTwoWeekHigh, fiftyTwoWeekLow, highPrice, last: Int
    let lowPrice, mark, markChange, markPercentChange: Int
    let openPrice, percentChange, quoteTime: Int
    let symbol: String
    let totalVolume, tradeTime: Int

    enum CodingKeys: String, CodingKey {
        case ask, askSize, bid, bidSize, change, close, delayed
        case underlyingDescription = "description"
        case exchangeName, fiftyTwoWeekHigh, fiftyTwoWeekLow, highPrice, last, lowPrice, mark, markChange, markPercentChange, openPrice, percentChange, quoteTime, symbol, totalVolume, tradeTime
    }
}
