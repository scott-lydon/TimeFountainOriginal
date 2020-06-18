//
//  Balances.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Balances: Codable {
    let accruedInterest, cashBalance, cashReceipts, longOptionMarketValue: Double
    let liquidationValue, longMarketValue, moneyMarketFund, savings: Double
    let shortMarketValue, pendingDeposits, availableFunds, availableFundsNonMarginableTrade: Double
    let buyingPower, buyingPowerNonMarginableTrade, dayTradingBuyingPower, dayTradingBuyingPowerCall: Double
    let equity, equityPercentage, longMarginValue, maintenanceCall: Double
    let maintenanceRequirement, marginBalance, regTCall, shortBalance: Double
    let shortMarginValue, shortOptionMarketValue, sma, mutualFundValue: Double
    let bondValue: Double
    let isInCall: Bool
    let stockBuyingPower, optionBuyingPower: Double
}
