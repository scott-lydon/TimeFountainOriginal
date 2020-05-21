//
//  InstrumentDetails.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct InstrumentDetails: Codable {
    let cusip, symbol, instrumentDetailsDescription, exchange: String
    let assetType: String

    enum CodingKeys: String, CodingKey {
        case cusip, symbol
        case instrumentDetailsDescription = "description"
        case exchange, assetType
    }
}
