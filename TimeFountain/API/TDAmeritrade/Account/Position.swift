//
//  Position.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Position: Codable {
    let shortQuantity, averagePrice, currentDayProfitLoss, currentDayProfitLossPercentage: Double
    let longQuantity, settledLongQuantity, settledShortQuantity, agedQuantity: Double
    let instrument: Instrument
    let marketValue: Double
}
