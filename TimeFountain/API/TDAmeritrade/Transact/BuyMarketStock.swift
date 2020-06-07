//
//  BuyMarketStock.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/5/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
// All tickers
// https://pkgstore.datahub.io/core/nasdaq-listings/nasdaq-listed-symbols_csv/data/595a1f263719c09a8a0b4a64f17112c6/nasdaq-listed-symbols_csv.csv

// Finviz
// https://finviz.com/screener.ashx?v=111&f=sh_avgvol_u500,sh_curvol_o400,sh_price_u10,ta_change_u9,ta_gap_u,ta_rsi_nob60&ft=4


protocol Order: Codable {}

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

// MARK: - TransactionRequest
struct TransactionRequest: Codable {
    let session: Session
    let duration: Duration
    let orderType: OrderType
    let cancelTime: CancelTime
    let complexOrderStrategyType: ComplexOrderStrategyType
    let quantity: Int
    let filledQuantity: Int
    let remainingQuantity: Int
    let requestedDestination: RequestDestination
    let destinationLinkName: String
    let releaseTime: String
    let stopPrice: Int
    let stopPriceLinkBasis: StopPriceLinkBasis
    let stopPriceLinkType: StopPriceLinkType
    let stopPriceOffset: Int
    let stopType: StopType
    let priceLinkBasis: PriceLinkBasis
    let priceLinkType: PriceLinkType
    let price: Int
    let taxLotMethod: TaxLotMethod
    let orderLegCollection: [OrderLegCollection]
    let activationPrice: Int
    let specialInstruction: SpecialInstruction
    let orderStrategyType: OrderStrategyType
    let orderID: Int
    let cancelable: Bool
    let editable: Bool
    let status: Status
    let enteredTime: String
    let closeTime: String
    let accountID: Int
    let orderActivityCollection: [ExecutionOrderActivity]
    let replacingOrderCollection: [ChildOrderStrategy]
    let childOrderStrategies: [ChildOrderStrategy]
    let statusDescription: String

    enum CodingKeys: String, CodingKey {
        case session, duration, orderType, cancelTime, complexOrderStrategyType, quantity, filledQuantity, remainingQuantity, requestedDestination, destinationLinkName, releaseTime, stopPrice, stopPriceLinkBasis, stopPriceLinkType, stopPriceOffset, stopType, priceLinkBasis, priceLinkType, price, taxLotMethod, orderLegCollection, activationPrice, specialInstruction, orderStrategyType
        case orderID = "orderId"
        case cancelable, editable, status, enteredTime, closeTime
        case accountID = "accountId"
        case orderActivityCollection, replacingOrderCollection, childOrderStrategies, statusDescription
    }
}

typealias InstrumentCodable = InstrumentProtocol & Codable

protocol InstrumentProtocol {
    var assetType: AssetType { get set }
    var cusip: String { get set }
    var symbol: Symbol { get set }
    var description: String { get set }
    // "instrument": "The type <Instrument> has the following subclasses [Equity, FixedIncome, MutualFund, CashEquivalent, Option] descriptions are listed below\"",
}

struct GeneralInstrument: Codable {
    var assetType: AssetType
    var cusip: String
    var symbol: Symbol
    var description: String
    
    var maturityDate: String?
    var variableRate: Int?
    var factor: Int?
    
    var mutualType: MutualFundType?
    var cashType: CashEquivalentType?
    
    var type: OptionType?
    var putCall: PutCall?
    var underlyingSymbol: Symbol?
    var optionMultiplier: Int?
    var optionDeliverables: [OptionDeliverabley]?
    
//    static func equity(
//        assetType: AssetType,
//        cusip: String,
//        symbol: Symbol,
//        description: String
//    ) -> GeneralInstrument {
//
//    }
}

struct Equity: InstrumentCodable {
    var assetType: AssetType
    var cusip: String
    var symbol: Symbol
    var description: String
}

struct FixedIncomeInstrument: InstrumentCodable {
    var assetType: AssetType
    var cusip: String
    var symbol: Symbol
    var description: String
    var maturityDate: String
    var variableRate: Int
    var factor: Int
}

struct MutualFundInstrument: InstrumentCodable {
    var assetType: AssetType
    var cusip: String
    var symbol: Symbol
    var description: String
    var type: MutualFundType
}

struct CashEquivalentInstrument: InstrumentCodable {
    var assetType: AssetType
    var cusip: String
    var symbol: Symbol
    var description: String
    var type: CashEquivalentType
}

struct OptionInstrument: InstrumentCodable {
    var assetType: AssetType
    var cusip: String
    var symbol: Symbol
    var description: String
    var type: OptionType
    var putCall: PutCall
    var underlyingSymbol: Symbol
    var optionMultiplier: Int
    var optionDeliverables: [OptionDeliverabley]
}

struct OptionDeliverabley: Codable {
    let symbol: Symbol
    let deliverableUnits: Int
    let currencyType: CurrencyType
    let assetType: AssetType
}

struct ExecutionOrderActivity: Codable {
    var activityType: ActivityType
    var executionType: ExecutionType = .FILL
    var quantity: Int
    var orderRemainingQuantity: Int
    var executionLegs: [ExecutionLegey]
}

// MARK: - OrderLeg
struct OrderLeg: Codable {
    let orderLegType: OrderLegType
    let legID: Int
    let instrument: GeneralInstrument
    let instruction: Instruction
    let positionEffect: PositionEffect
    let quantity: Int
   let quantityType: QuantityType

    enum CodingKeys: String, CodingKey {
        case orderLegType
        case legID = "legId"
        case instruction, positionEffect, quantity, quantityType, instrument
    }
}


struct ExecutionLegey: Codable {
    let legID, quantity, mismarkedQuantity, price: Int
    let time: String

    enum CodingKeys: String, CodingKey {
        case legID = "legId"
        case quantity, mismarkedQuantity, price, time
    }
}

struct BuyMarketStock: Codable, Order  {
    let orderType, session, duration, orderStrategyType: String
    let orderLegCollection: [OrderLegCollection]
}

// MARK: - OrderLegCollection
struct OrderLegCollection: Codable, Order {
    let instruction: String
    let quantity: Int
    let instrument: Instrument
}

// MARK: - BuyLimitSingleOption
struct BuyLimitSingleOption: Codable, Order {
    let complexOrderStrategyType, orderType, session, price: String
    let duration, orderStrategyType: String
    let orderLegCollection: [OrderLegCollection]
}

// MARK: - BuyLimitVerticalCallSpread
struct BuyLimitVerticalCallSpread: Codable, Order {
    let orderType, session, price, duration: String
    let orderStrategyType: String
    let orderLegCollection: [OrderLegCollection]
}

// MARK: - CustomOptionSpread
struct CustomOptionSpread: Codable, Order {
    let orderStrategyType, orderType: String
    let orderLegCollection: [OrderLegCollection]
    let complexOrderStrategyType, duration, session: String
}

// MARK: - ConditionalOrder
struct ConditionalOrder: Codable, Order {
    let orderType, session, price, duration: String
    let orderStrategyType: String
    let orderLegCollection: [OrderLegCollection]
    let childOrderStrategies: [ConditionalOrder]?
}

// MARK: - ConditionalCancelOrder
struct ConditionalCancelOrder: Codable, Order {
    let orderStrategyType: String
    let childOrderStrategies: [ChildOrderStrategy]
}


// MARK: - ChildOrderStrategy
struct ChildOrderStrategy: Codable, Order {
    let orderStrategyType: String
    let orderLegCollection: [OrderLegCollection] = []
    let childOrderStrategies: [DoubleTrigger] = []
    let stopPrice: String?
    let orderType, session, price, duration: String?
}


// MARK: - DoubleTrigger
struct DoubleTrigger: Codable, Order {
    let orderStrategyType, session, duration, orderType: String
    let price: Double?
    let orderLegCollection: [OrderLegCollection]
    let childOrderStrategies: [ChildOrderStrategy]?
    let stopPrice: Double?
}

// MARK: - SellTrailing
struct SellTrailing: Codable, Order {
    let complexOrderStrategyType, orderType, session, stopPriceLinkBasis: String
    let stopPriceLinkType: String
    let stopPriceOffset: Int
    let duration, orderStrategyType: String
    let orderLegCollection: [OrderLegCollection]
}
