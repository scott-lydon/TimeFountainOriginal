//
//  InitialBalances.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct InitialBalances: Codable {
    let accruedInterest, availableFundsNonMarginableTrade, bondValue, buyingPower: Int
    let cashBalance, cashAvailableForTrading, cashReceipts, dayTradingBuyingPower: Int
    let dayTradingBuyingPowerCall, dayTradingEquityCall, equity, equityPercentage: Int
    let liquidationValue, longMarginValue, longOptionMarketValue, longStockValue: Int
    let maintenanceCall, maintenanceRequirement, margin, marginEquity: Int
    let moneyMarketFund, mutualFundValue, regTCall, shortMarginValue: Int
    let shortOptionMarketValue, shortStockValue, totalCash: Int
    let isInCall: Bool
    let unsettledCash, pendingDeposits, marginBalance, shortBalance: Int
    let accountValue: Int
}
