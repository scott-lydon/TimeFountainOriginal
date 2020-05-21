//
//  FixedIncome.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct FixedIncome: Codable {
    let assetType, cusip, symbol, fixedIncomeDescription: String
    let maturityDate: String
    let variableRate, factor: Int

    enum CodingKeys: String, CodingKey {
        case assetType, cusip, symbol
        case fixedIncomeDescription = "description"
        case maturityDate, variableRate, factor
    }
}
