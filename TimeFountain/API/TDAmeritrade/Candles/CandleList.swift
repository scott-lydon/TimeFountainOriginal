//
//  CandleList.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct CandleList: Codable {
    let candles: [Candle]
    let empty: Bool
    let symbol: String
    
    var closes: [Double] {
        return candles.map {$0.close}
    }
    
    var dates: [Double] {
        return candles.map { $0.datetime }
    }
}
