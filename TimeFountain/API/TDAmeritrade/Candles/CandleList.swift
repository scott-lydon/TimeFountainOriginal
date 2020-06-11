//
//  CandleList.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct CandleList: Codable {
    var candles: [Candle]
    let empty: Bool
    let symbol: String
    
    var closes: [Double] {
        candles.map {$0.close}
    }
    
    var dates: [Double] {
        candles.map { $0.datetime }
    }
    
    init(candles: [Candle] = [], empty: Bool = true, symbol: String) {
        self.candles = candles
        self.empty = empty
        self.symbol = symbol
    }
}
