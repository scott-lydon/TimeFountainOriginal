//
//  QuoteEquity.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct QuoteEquity: Codable {
    let symbol, quoteEquityDescription: String
    let bidPrice, bidSize: Int
    let bidID: String
    let askPrice, askSize: Int
    let askID: String
    let lastPrice, lastSize: Int
    let lastID: String
    let openPrice, highPrice, lowPrice, closePrice: Int
    let netChange, totalVolume, quoteTimeInLong, tradeTimeInLong: Int
    let mark: Int
    let exchange, exchangeName: String
    let marginable, shortable: Bool
    let volatility, digits, the52WkHigh, the52WkLow: Int
    let peRatio, divAmount, divYield: Int
    let divDate, securityStatus: String
    let regularMarketLastPrice, regularMarketLastSize, regularMarketNetChange, regularMarketTradeTimeInLong: Int

    enum CodingKeys: String, CodingKey {
        case symbol
        case quoteEquityDescription = "description"
        case bidPrice, bidSize
        case bidID = "bidId"
        case askPrice, askSize
        case askID = "askId"
        case lastPrice, lastSize
        case lastID = "lastId"
        case openPrice, highPrice, lowPrice, closePrice, netChange, totalVolume, quoteTimeInLong, tradeTimeInLong, mark, exchange, exchangeName, marginable, shortable, volatility, digits
        case the52WkHigh = "52WkHigh"
        case the52WkLow = "52WkLow"
        case peRatio, divAmount, divYield, divDate, securityStatus, regularMarketLastPrice, regularMarketLastSize, regularMarketNetChange, regularMarketTradeTimeInLong
    }
}
