//
//  Position.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Position: Codable {
    let shortQuantity, averagePrice, currentDayProfitLoss, currentDayProfitLossPercentage: Int
    let longQuantity, settledLongQuantity, settledShortQuantity, agedQuantity: Int
    let instrument: String
    let marketValue: Int
}
