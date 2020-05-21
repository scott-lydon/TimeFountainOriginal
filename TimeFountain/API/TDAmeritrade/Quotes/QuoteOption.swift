//
//  QuoteOption.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct QuoteOption: Codable {
    let symbol, quoteOptionDescription: String
    let bidPrice, bidSize, askPrice, askSize: Int
    let lastPrice, lastSize, openPrice, highPrice: Int
    let lowPrice, closePrice, netChange, totalVolume: Int
    let quoteTimeInLong, tradeTimeInLong, mark, openInterest: Int
    let volatility, moneyIntrinsicValue, multiplier, strikePrice: Int
    let contractType, underlying: String
    let timeValue: Int
    let deliverables: String
    let delta, gamma, theta, vega: Int
    let rho: Int
    let securityStatus: String
    let theoreticalOptionValue, underlyingPrice: Int
    let uvExpirationType, exchange, exchangeName, settlementType: String

    enum CodingKeys: String, CodingKey {
        case symbol
        case quoteOptionDescription = "description"
        case bidPrice, bidSize, askPrice, askSize, lastPrice, lastSize, openPrice, highPrice, lowPrice, closePrice, netChange, totalVolume, quoteTimeInLong, tradeTimeInLong, mark, openInterest, volatility, moneyIntrinsicValue, multiplier, strikePrice, contractType, underlying, timeValue, deliverables, delta, gamma, theta, vega, rho, securityStatus, theoreticalOptionValue, underlyingPrice, uvExpirationType, exchange, exchangeName, settlementType
    }
}
