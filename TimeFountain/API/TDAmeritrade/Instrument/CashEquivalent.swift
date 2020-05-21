//
//  CashEquivalent.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct CashEquivalent: Codable, Instrument {
    let assetType, cusip, symbol, cashEquivalentDescription: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case assetType, cusip, symbol
        case cashEquivalentDescription = "description"
        case type
    }
}
