//
//  CashEquivalent.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

class CashEquivalent: Instrument {
    let cashEquivalentDescription: String
    let type: CashEquivalentType

    private enum CodingKeys: String, CodingKey {
        case cashEquivalentDescription = "description"
        case type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cashEquivalentDescription = try container.decode(String.self, forKey: .cashEquivalentDescription)
        self.type = try container.decode(CashEquivalentType.self, forKey: .cashEquivalentDescription)
        try super.init(from: decoder)
    }
}
