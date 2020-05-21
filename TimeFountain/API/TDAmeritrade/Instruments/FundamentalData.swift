//
//  FundamentalData.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct FundamentalData: Codable {
    let symbol: String
    let high52, low52, dividendAmount, dividendYield: Int
    let dividendDate: String
    let peRatio, pegRatio, pbRatio, prRatio: Int
    let pcfRatio, grossMarginTTM, grossMarginMRQ, netProfitMarginTTM: Int
    let netProfitMarginMRQ, operatingMarginTTM, operatingMarginMRQ, returnOnEquity: Int
    let returnOnAssets, returnOnInvestment, quickRatio, currentRatio: Int
    let interestCoverage, totalDebtToCapital, ltDebtToEquity, totalDebtToEquity: Int
    let epsTTM, epsChangePercentTTM, epsChangeYear, epsChange: Int
    let revChangeYear, revChangeTTM, revChangeIn, sharesOutstanding: Int
    let marketCapFloat, marketCap, bookValuePerShare, shortIntToFloat: Int
    let shortIntDayToCover, divGrowthRate3Year, dividendPayAmount: Int
    let dividendPayDate: String
    let beta, vol1DayAvg, vol10DayAvg, vol3MonthAvg: Int
}
