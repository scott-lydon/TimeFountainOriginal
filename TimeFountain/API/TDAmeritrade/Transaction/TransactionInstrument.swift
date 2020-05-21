//
//  TransactionInstrument.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct TransactionInstrument: Codable {
    let symbol, underlyingSymbol, optionExpirationDate: String
    let optionStrikePrice: Int
    let putCall, cusip, instrumentDescription, assetType: String
    let bondMaturityDate: String
    let bondInterestRate: Int

    enum CodingKeys: String, CodingKey {
        case symbol, underlyingSymbol, optionExpirationDate, optionStrikePrice, putCall, cusip
        case instrumentDescription = "description"
        case assetType, bondMaturityDate, bondInterestRate
    }
}
