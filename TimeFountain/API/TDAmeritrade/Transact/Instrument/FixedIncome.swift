//
//  FixedIncome.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

class FixedIncome: Instrument {
    let fixedIncomeDescription: String
    let maturityDate: String
    let variableRate, factor: Double

    private enum CodingKeys: String, CodingKey {
        case fixedIncomeDescription = "description"
        case maturityDate, variableRate, factor
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fixedIncomeDescription = try container.decode(String.self, forKey: .fixedIncomeDescription)
        self.maturityDate = try container.decode(String.self, forKey: .maturityDate)
        self.variableRate = try container.decode(Double.self, forKey: .variableRate)
        self.factor = try container.decode(Double.self, forKey: .factor)
        try super.init(from: decoder)
    }
}
