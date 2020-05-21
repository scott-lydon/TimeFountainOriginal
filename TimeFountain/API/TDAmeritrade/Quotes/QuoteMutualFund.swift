//
//  MutualFundQuotes.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct QuoteMutualFund: Codable {
    let symbol, mutualFundDescription: String
    let closePrice, netChange, totalVolume, tradeTimeInLong: Int
    let exchange, exchangeName: String
    let digits, the52WkHigh, the52WkLow, nAV: Int
    let peRatio, divAmount, divYield: Int
    let divDate, securityStatus: String

    enum CodingKeys: String, CodingKey {
        case symbol
        case mutualFundDescription = "description"
        case closePrice, netChange, totalVolume, tradeTimeInLong, exchange, exchangeName, digits
        case the52WkHigh = "52WkHigh"
        case the52WkLow = "52WkLow"
        case nAV, peRatio, divAmount, divYield, divDate, securityStatus
    }
}
