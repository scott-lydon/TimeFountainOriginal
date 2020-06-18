//
//  Predictable.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/18/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

protocol Predictable {}
extension Predictable {
    func prediction(from: DataFrame) -> BuyMarketStock.Prediction {
        .init(direction: .goingDown, percentile: .lowerFifty)
    }
}
extension TSLA: Predictable {}
