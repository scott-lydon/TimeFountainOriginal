//
//  Execution.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

//typeAlias OrderActivity = Execution

struct Execution: Codable {
    let activityType: ActivityType
    let executionType: ExecutionType
    let quantity: Int
    let orderRemainingQuantity: Int
    let executionLegs: [ExecutionLeg]
}

struct ExecutionLeg: Codable {
    let legID: Int
    let quantity: Int
    let mismarkedQuantity: Int
    let price: Double
    let time: String

    enum CodingKeys: String, CodingKey {
        case legID = "legId"
        case quantity, mismarkedQuantity, price, time
    }
}
