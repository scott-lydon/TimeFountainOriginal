//
//  QuoteIndex.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct QuoteIndex: Codable {
    let symbol, quoteIndexDescription: String
    let lastPrice, openPrice, highPrice, lowPrice: Int
    let closePrice, netChange, totalVolume, tradeTimeInLong: Int
    let exchange, exchangeName: String
    let digits, the52WkHigh, the52WkLow: Int
    let securityStatus: String

    enum CodingKeys: String, CodingKey {
        case symbol
        case quoteIndexDescription = "description"
        case lastPrice, openPrice, highPrice, lowPrice, closePrice, netChange, totalVolume, tradeTimeInLong, exchange, exchangeName, digits
        case the52WkHigh = "52WkHigh"
        case the52WkLow = "52WkLow"
        case securityStatus
    }
}
