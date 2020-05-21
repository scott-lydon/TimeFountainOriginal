//
//  Execution.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Execution: Codable, Instrument {
    let activityType, executionType: String
    let quantity, orderRemainingQuantity: Int
    let executionLegs: [ExecutionLeg]
}

struct ExecutionLeg: Codable {
    let legID, quantity, mismarkedQuantity, price: Int
    let time: String

    enum CodingKeys: String, CodingKey {
        case legID = "legId"
        case quantity, mismarkedQuantity, price, time
    }
}
