//
//  QuoteForex.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct QuoteForex: Codable {
    let symbol: String
    let bidPriceInDouble, askPriceInDouble, lastPriceInDouble, highPriceInDouble: Int
    let lowPriceInDouble, closePriceInDouble: Int
    let exchange, quoteForexDescription: String
    let openPriceInDouble, changeInDouble, percentChange: Int
    let exchangeName: String
    let digits: Int
    let securityStatus: String
    let tick, tickAmount: Int
    let product, tradingHours: String
    let isTradable: Bool
    let marketMaker: String
    let the52WkHighInDouble, the52WkLowInDouble, mark: Int

    enum CodingKeys: String, CodingKey {
        case symbol, bidPriceInDouble, askPriceInDouble, lastPriceInDouble, highPriceInDouble, lowPriceInDouble, closePriceInDouble, exchange
        case quoteForexDescription = "description"
        case openPriceInDouble, changeInDouble, percentChange, exchangeName, digits, securityStatus, tick, tickAmount, product, tradingHours, isTradable, marketMaker
        case the52WkHighInDouble = "52WkHighInDouble"
        case the52WkLowInDouble = "52WkLowInDouble"
        case mark
    }
}
