//
//  Option.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Option: Codable {
    let putCall, symbol, optionDescription, exchangeName: String
    let bidPrice, askPrice, lastPrice, markPrice: Int
    let bidSize, askSize, lastSize, highPrice: Int
    let lowPrice, openPrice, closePrice, totalVolume: Int
    let quoteTimeInLong, tradeTimeInLong, netChange, volatility: Int
    let delta, gamma, theta, vega: Int
    let rho, timeValue, openInterest: Int
    let isInTheMoney: Bool
    let theoreticalOptionValue, theoreticalVolatility: Int
    let isMini, isNonStandard: Bool
    let optionDeliverablesList: [OptionDeliverablesList]
    let strikePrice: Int
    let expirationDate, expirationType: String
    let multiplier: Int
    let settlementType, deliverableNote: String
    let isIndexOption: Bool
    let percentChange, markChange, markPercentChange: Int

    enum CodingKeys: String, CodingKey {
        case putCall, symbol
        case optionDescription = "description"
        case exchangeName, bidPrice, askPrice, lastPrice, markPrice, bidSize, askSize, lastSize, highPrice, lowPrice, openPrice, closePrice, totalVolume, quoteTimeInLong, tradeTimeInLong, netChange, volatility, delta, gamma, theta, vega, rho, timeValue, openInterest, isInTheMoney, theoreticalOptionValue, theoreticalVolatility, isMini, isNonStandard, optionDeliverablesList, strikePrice, expirationDate, expirationType, multiplier, settlementType, deliverableNote, isIndexOption, percentChange, markChange, markPercentChange
    }
}
