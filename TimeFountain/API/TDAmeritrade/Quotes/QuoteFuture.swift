//
//  QuoteFuture.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


struct QuoteFuture: Codable {
    let symbol: String
    let bidPriceInDouble, askPriceInDouble, lastPriceInDouble: Int
    let bidID, askID: String
    let highPriceInDouble, lowPriceInDouble, closePriceInDouble: Int
    let exchange, quoteFutureDescription, lastID: String
    let openPriceInDouble, changeInDouble, futurePercentChange: Int
    let exchangeName, securityStatus: String
    let openInterest, mark, tick, tickAmount: Int
    let product, futurePriceFormat, futureTradingHours: String
    let futureIsTradable: Bool
    let futureMultiplier: Int
    let futureIsActive: Bool
    let futureSettlementPrice: Int
    let futureActiveSymbol, futureExpirationDate: String

    enum CodingKeys: String, CodingKey {
        case symbol, bidPriceInDouble, askPriceInDouble, lastPriceInDouble
        case bidID = "bidId"
        case askID = "askId"
        case highPriceInDouble, lowPriceInDouble, closePriceInDouble, exchange
        case quoteFutureDescription = "description"
        case lastID = "lastId"
        case openPriceInDouble, changeInDouble, futurePercentChange, exchangeName, securityStatus, openInterest, mark, tick, tickAmount, product, futurePriceFormat, futureTradingHours, futureIsTradable, futureMultiplier, futureIsActive, futureSettlementPrice, futureActiveSymbol, futureExpirationDate
    }
}
