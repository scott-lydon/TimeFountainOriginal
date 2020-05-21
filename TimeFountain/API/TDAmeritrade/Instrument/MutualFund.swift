//
//  MutualFund.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct MutualFund: Codable {
    let assetType, cusip, symbol, mutualFundDescription: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case assetType, cusip, symbol
        case mutualFundDescription = "description"
        case type
    }
}
