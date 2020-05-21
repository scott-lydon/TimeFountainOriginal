//
//  Balances.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Balances: Codable {
    let accruedInterest, cashBalance, cashReceipts, longOptionMarketValue: Int
    let liquidationValue, longMarketValue, moneyMarketFund, savings: Int
    let shortMarketValue, pendingDeposits, availableFunds, availableFundsNonMarginableTrade: Int
    let buyingPower, buyingPowerNonMarginableTrade, dayTradingBuyingPower, dayTradingBuyingPowerCall: Int
    let equity, equityPercentage, longMarginValue, maintenanceCall: Int
    let maintenanceRequirement, marginBalance, regTCall, shortBalance: Int
    let shortMarginValue, shortOptionMarketValue, sma, mutualFundValue: Int
    let bondValue: Int
    let isInCall: Bool
    let stockBuyingPower, optionBuyingPower: Int
}
