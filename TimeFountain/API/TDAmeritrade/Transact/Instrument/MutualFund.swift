//
//  MutualFund.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

class MutualFund: Instrument {
    let mutualFundDescription: String
    let type: MutualFundType

    enum CodingKeys: String, CodingKey {
        case assetType, cusip, symbol
        case mutualFundDescription = "description"
        case type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mutualFundDescription = try container.decode(String.self, forKey: .mutualFundDescription)
        self.type = try container.decode(MutualFundType.self, forKey: .type)
        try super.init(from: decoder)
    }
}
