//
//  Option.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Option: Codable {
    let assetType, cusip, symbol, optionDescription: String
    let type, putCall, underlyingSymbol: String
    let optionMultiplier: Int
    let optionDeliverables: [OptionDeliverable]

    enum CodingKeys: String, CodingKey {
        case assetType, cusip, symbol
        case optionDescription = "description"
        case type, putCall, underlyingSymbol, optionMultiplier, optionDeliverables
    }
}

struct OptionDeliverable: Codable {
    let symbol: String
    let deliverableUnits: Int
    let currencyType, assetType: String
}
