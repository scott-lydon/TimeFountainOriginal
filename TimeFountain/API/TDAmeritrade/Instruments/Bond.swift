//
//  Bond.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Bond: Codable {
    let bondPrice: Int
    let cusip, symbol, bondDescription, exchange: String
    let assetType: String

    enum CodingKeys: String, CodingKey {
        case bondPrice, cusip, symbol
        case bondDescription = "description"
        case exchange, assetType
    }
}
