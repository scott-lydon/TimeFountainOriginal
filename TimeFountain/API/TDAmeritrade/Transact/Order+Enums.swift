//
//  Order+Enums.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/8/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

enum SpecialInstruction: String, Codable {
    case ALL_OR_NONE, DO_NOT_REDUCE, ALL_OR_NONE_DO_NOT_REDUCE
}

enum OrderType: String, Codable {
    case MARKET, LIMIT, NET_DEBIT, STOP_LIMIT, STOP, TRAILING_STOP, MARKET_ON_CLOSE, EXERCISE, TRAILING_STOP_LIMIT, NET_CREDIT, NET_ZERO
}

enum Session: String, Codable {
    case NORMAL, AM, PM, SEAMLESS
}

enum Duration: String, Codable {
    case GOOD_TILL_CANCEL, DAY, FILL_OR_KILL
}

enum OrderStrategyType: String, Codable {
    case SINGLE, TRIGGER, OCO
}

enum Instruction: String, Codable {
    case Buy, BUY_TO_OPEN, SELL_TO_OPEN, BUY, SELL, BUY_TO_COVER, BUY_TO_CLOSE, SELL_SHORT, SELL_TO_CLOSE, EXCHANGE
    
    init?(_ direction: BuyMarketStock.Prediction.Direction) {
        switch direction {
        case .goingUp:
            self = .BUY
        case .goingDown:
            self = .SELL
        case .level:
            return nil
        }
    }
}

enum AssetType: String, Codable {
    case EQUITY, OPTION, INDEX, MUTUAL_FUND, CASH_EQUIVALENT, FIXED_INCOME, CURRENCY
}

enum ComplexOrderStrategyType: String, Codable {
    case NONE, CUSTOM, COVERED, VERTICAL, BACK_RATIO, CALENDAR, DIAGONAL, STRADDLE, STRANGLE, COLLAR_SYNTHETIC, BUTTERFLY, CONDOR, IRON_CONDOR, VERTICAL_ROLL, COLLAR_WITH_STOCK, DOUBLE_DIAGONAL, UNBALANCED_BUTTERFLY, UNBALANCED_CONDOR, UNBALANCED_IRON_CONDOR, UNBALANCED_VERTICAL_ROLL
}

enum StopPriceLinkBasis: String, Codable {
    case BID, MANUAL, BASE, TRIGGER, LAST, ASK, ASK_BID, MARK, AVERAGE
}

enum StopPriceLinkType: String, Codable {
    case VALUE, PERCENT, TICK
}

enum RequestDestination: String, Codable {
    case INET, ECN_ARCA, CBOE, AMEX, PHLX, ISE, BOX, NYSE, NASDAQ, BATS, C2, AUTO
}

enum StopType: String, Codable {
    case STANDARD, BID, ASK, LAST, MARK
}

enum PriceLinkBasis: String, Codable {
    case MANUAL, BASE, TRIGGER, LAST, BID, ASK, ASK_BID, MARK, AVERAGE
}

enum PriceLinkType: String, Codable {
    case VALUE, PERCENT, TICK
}

enum TaxLotMethod: String, Codable {
    case FIFO, LIFO, HIGH_COST, LOW_COST, AVERAGE_COST, SPECIFIC_LOT
}

enum OrderLegType: String, Codable {
    case EQUITY, OPTION, INDEX, MUTUAL_FUND, CASH_EQUIVALENT, FIXED_INCOME, CURRENCY
}

enum PositionEffect: String, Codable {
    case OPENING, CLOSING, AUTOMATIC
}

enum QuantityType: String, Codable {
    case ALL_SHARES, DOLLARS, SHARES
}

enum Status: String, Codable {
    case AWAITING_PARENT_ORDER, AWAITING_CONDITION, AWAITING_MANUAL_REVIEW, ACCEPTED, AWAITING_UR_OUT, PENDING_ACTIVATION, QUEUED, WORKING, REJECTED, PENDING_CANCEL, CANCELED, PENDING_REPLACE, REPLACED, FILLED, EXPIRED
}

enum PutCall: String, Codable {
    case PUT, CALL
}

enum CurrencyType: String, Codable {
    case USD, CAD, EUR, JPY
}

enum ActivityType: String, Codable {
    case EXECUTION, ORDER_ACTION
}

enum ExecutionType: String, Codable {
    case FILL
}
// TYPES
enum MutualFundType: String, Codable {
    case NOT_APPLICABLE, OPEN_END_NON_TAXABLE, OPEN_END_TAXABLE, NO_LOAD_NON_TAXABLE, NO_LOAD_TAXABLE
}

enum CashEquivalentType: String, Codable {
    case SAVINGS, MONEY_MARKET_FUND
}

enum OptionType: String, Codable {
    case VANILLA, BINARY, BARRIER
}

enum Symbol: String, Codable {
    case ADMS, DRAD, LXU, MCEP, NCSM, RMBL, SNMP
}
