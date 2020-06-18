//
//  Option.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

class Option: Instrument {
    let optionDescription: String
    let type: OptionType
    let putCall: PutCall
    let underlyingSymbol: String
    let optionMultiplier: Int
    let optionDeliverables: [OptionDeliverable]

    private enum CodingKeys: String, CodingKey {
        case optionDescription = "description"
        case type, putCall, underlyingSymbol, optionMultiplier, optionDeliverables
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.optionDescription = try container.decode(String.self, forKey: .optionDescription)
        self.type = try container.decode(OptionType.self, forKey: .type)
        self.putCall = try container.decode(PutCall.self, forKey: .putCall)
        self.underlyingSymbol = try container.decode(String.self, forKey: .underlyingSymbol)
        self.optionMultiplier = try container.decode(Int.self, forKey: .optionMultiplier)
        self.optionDeliverables = try container.decode([OptionDeliverable].self, forKey: .optionDeliverables)
        try super.init(from: decoder)
    }
}

struct OptionDeliverable: Codable {
    let symbol: String
    let deliverableUnits: Int
    let currencyType: CurrencyType
    let assetType: AssetType
}
