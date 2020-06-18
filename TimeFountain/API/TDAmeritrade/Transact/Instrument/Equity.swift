//
//  Equity.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/17/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

class Equity: Instrument {
    var description: String
    
    private enum CodingKeys: String, CodingKey {
        case description
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
        try super.init(from: decoder)
    }
}
