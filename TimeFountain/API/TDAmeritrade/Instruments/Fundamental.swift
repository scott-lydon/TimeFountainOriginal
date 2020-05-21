//
//  Fundamental.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Fundamental: Codable {
    let cusip, symbol, fundamentalDescription, exchange: String
    let assetType: String
    let fundamental: FundamentalClass

    enum CodingKeys: String, CodingKey {
        case cusip, symbol
        case fundamentalDescription = "description"
        case exchange, assetType, fundamental
    }
}
