//
//  TransactionItem.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct TransactionItem: Codable {
    let accountID, amount, price, cost: Int
    let parentOrderKey: Int
    let parentChildIndicator, instruction, positionEffect: String
    let instrument: TransactionInstrument

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case amount, price, cost, parentOrderKey, parentChildIndicator, instruction, positionEffect, instrument
    }
}
