//
//  MarginAccount.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct MarginAccount {
    let type, accountID: String
    let roundTrips: Int
    let isDayTrader, isClosingOnlyRestricted: Bool
    let positions: [Position]
    let orderStrategies: [OrderStrategy]
    let initialBalances: InitialBalances
    let currentBalances, projectedBalances: Balances

    enum CodingKeys: String, CodingKey {
        case type
        case accountID = "accountId"
        case roundTrips, isDayTrader, isClosingOnlyRestricted, positions, orderStrategies, initialBalances, currentBalances, projectedBalances
    }
}
