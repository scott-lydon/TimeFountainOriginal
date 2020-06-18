//
//  Instrument.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/17/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

class Instrument: Codable {
    var assetType: AssetType
    var cusip: String
    var symbol: Symbol
    
    private enum CodingKeys: String, CodingKey {
        case assetType, cusip, symbol
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.assetType = try container.decode(AssetType.self, forKey: .assetType)
        self.cusip = try container.decode(String.self, forKey: .cusip)
        self.symbol = try container.decode(Symbol.self, forKey: .symbol)
    }
}
