//
//  OptionChain.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct OptionChain: Codable {
    let symbol, status: String
    let underlying: Underlying
    let strategy: String
    let interval: Int
    let isDelayed, isIndex: Bool
    let daysToExpiration, interestRate, underlyingPrice, volatility: Int
    let callExpDateMap, putExpDateMap: String
}
