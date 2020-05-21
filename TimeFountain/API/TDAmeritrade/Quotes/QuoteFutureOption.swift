//
//  QuoteFutureOption.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct QuoteFutureOption: Codable {
    let symbol: String
    let bidPriceInDouble, askPriceInDouble, lastPriceInDouble, highPriceInDouble: Int
    let lowPriceInDouble, closePriceInDouble: Int
    let quoteFutureOptionDescription: String
    let openPriceInDouble, netChangeInDouble, openInterest: Int
    let exchangeName, securityStatus: String
    let volatility, moneyIntrinsicValueInDouble, multiplierInDouble, digits: Int
    let strikePriceInDouble: Int
    let contractType, underlying: String
    let timeValueInDouble, deltaInDouble, gammaInDouble, thetaInDouble: Int
    let vegaInDouble, rhoInDouble, mark, tick: Int
    let tickAmount: Int
    let futureIsTradable: Bool
    let futureTradingHours: String
    let futurePercentChange: Int
    let futureIsActive: Bool
    let futureExpirationDate: Int
    let expirationType, exerciseType: String
    let inTheMoney: Bool

    enum CodingKeys: String, CodingKey {
        case symbol, bidPriceInDouble, askPriceInDouble, lastPriceInDouble, highPriceInDouble, lowPriceInDouble, closePriceInDouble
        case quoteFutureOptionDescription = "description"
        case openPriceInDouble, netChangeInDouble, openInterest, exchangeName, securityStatus, volatility, moneyIntrinsicValueInDouble, multiplierInDouble, digits, strikePriceInDouble, contractType, underlying, timeValueInDouble, deltaInDouble, gammaInDouble, thetaInDouble, vegaInDouble, rhoInDouble, mark, tick, tickAmount, futureIsTradable, futureTradingHours, futurePercentChange, futureIsActive, futureExpirationDate, expirationType, exerciseType, inTheMoney
    }
}
