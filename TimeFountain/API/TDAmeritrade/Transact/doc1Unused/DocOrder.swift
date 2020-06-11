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
/*
 struct BuyMarketStock: Order {
 let orderType: OrderType
 let session: Session
 let duration: Duration
 let orderStrategyType: OrderStrategyType
 let orderLegCollection: [OrderLegCollection]
 */

// MARK: - First page Documents specified Order types
struct TransactionRequest: Order {
    var session: Session?
    var duration: Duration?
    var orderType: OrderType?
    var cancelTime: CancelTime?
    var complexOrderStrategyType: ComplexOrderStrategyType?
    var quantity: Int?
    var filledQuantity: Int?
    var remainingQuantity: Int?
    var requestedDestination: RequestDestination?
    var destinationLinkName: String?
    var releaseTime: String?
    var stopPrice: String?
    var stopPriceLinkBasis: StopPriceLinkBasis?
    var stopPriceLinkType: StopPriceLinkType?
    var stopPriceOffset: Double?
    var stopType: StopType?
    var priceLinkBasis: PriceLinkBasis?
    var priceLinkType: PriceLinkType?
    var price: Double?
    var taxLotMethod: TaxLotMethod?
    var orderLegCollection: [OrderLegCollection]?
    var activationPrice: Double?
    var specialInstruction: SpecialInstruction?
    var orderStrategyType: OrderStrategyType?
    var orderID: Int?
    var cancelable: Bool?
    var editable: Bool?
    var status: Status?
    var enteredTime: String?
    var closeTime: String?
    var accountID: Int?
    var orderActivityCollection: [ExecutionOrderActivity]?
    var replacingOrderCollection: [ChildOrderStrategy]?
    var childOrderStrategies: [ChildOrderStrategy]?
    var statusDescription: String?

    enum CodingKeys: String, CodingKey {
        case session, duration, orderType, cancelTime, complexOrderStrategyType, quantity, filledQuantity, remainingQuantity, requestedDestination, destinationLinkName, releaseTime, stopPrice, stopPriceLinkBasis, stopPriceLinkType, stopPriceOffset, stopType, priceLinkBasis, priceLinkType, price, taxLotMethod, orderLegCollection, activationPrice, specialInstruction, orderStrategyType
        case orderID = "orderId"
        case cancelable, editable, status, enteredTime, closeTime
        case accountID = "accountId"
        case orderActivityCollection, replacingOrderCollection, childOrderStrategies, statusDescription
    }
    
    init(
        session: Session? = nil,
        duration: Duration? = nil,
        orderType: OrderType? = nil,
        cancelTime: CancelTime? = nil,
        complexOrderStrategyType: ComplexOrderStrategyType? = nil,
        quantity: Int? = nil,
        filledQuantity: Int? = nil,
        remainingQuantity: Int? = nil,
        requestedDestination: RequestDestination? = nil,
        destinationLinkName: String? = nil,
        releaseTime: String? = nil,
        stopPrice: String? = nil,
        stopPriceLinkBasis: StopPriceLinkBasis? = nil,
        stopPriceLinkType: StopPriceLinkType? = nil,
        stopPriceOffset: Double? = nil,
        stopType: StopType? = nil,
        priceLinkBasis: PriceLinkBasis? = nil,
        priceLinkType: PriceLinkType? = nil,
        price: Double? = nil,
        taxLotMethod: TaxLotMethod? = nil,
        orderLegCollection: [OrderLegCollection]? = nil,
        activationPrice: Double? = nil,
        specialInstruction: SpecialInstruction? = nil,
        orderStrategyType: OrderStrategyType? = nil,
        orderID: Int? = nil,
        cancelable: Bool? = nil,
        editable: Bool? = nil,
        status: Status? = nil,
        enteredTime: String? = nil,
        closeTime: String? = nil,
        accountID: Int? = nil,
        orderActivityCollection: [ExecutionOrderActivity]? = nil,
        replacingOrderCollection: [ChildOrderStrategy]? = nil,
        childOrderStrategies: [ChildOrderStrategy]? = nil,
        statusDescription: String? = nil
    ) {
        self.session = session
        self.duration = duration
        self.orderType = orderType
        self.cancelTime = cancelTime
        self.complexOrderStrategyType = complexOrderStrategyType
        self.quantity = quantity
        self.filledQuantity = filledQuantity
        self.remainingQuantity = remainingQuantity
        self.requestedDestination = requestedDestination
        self.destinationLinkName = destinationLinkName
        self.releaseTime = releaseTime
        self.stopPrice = stopPrice
        self.stopPriceLinkBasis = stopPriceLinkBasis
        self.stopPriceLinkType = stopPriceLinkType
        self.stopPriceOffset = stopPriceOffset
        self.stopType = stopType
        self.priceLinkBasis = priceLinkBasis
        self.priceLinkType = priceLinkType
        self.price = price
        self.taxLotMethod = taxLotMethod
        self.orderLegCollection = orderLegCollection
        self.activationPrice = activationPrice
        self.specialInstruction = specialInstruction
        self.orderStrategyType = orderStrategyType
        self.orderID = orderID
        self.cancelable = cancelable
        self.editable = editable
        self.status = status
        self.enteredTime = enteredTime
        self.closeTime = closeTime
        self.accountID = accountID
        self.orderActivityCollection = orderActivityCollection
        self.replacingOrderCollection = replacingOrderCollection
        self.childOrderStrategies = childOrderStrategies
        self.statusDescription = statusDescription
    }
    
    static func buyMarketStock(
        orderType: OrderType,
        session: Session,
        duration: Duration,
        orderStrategyType: OrderStrategyType,
        orderLegCollection: [OrderLegCollection]
    ) -> TransactionRequest {
        TransactionRequest(
            session: session,
            duration: duration,
            orderType: orderType,
            orderLegCollection:
            orderLegCollection,
            orderStrategyType: orderStrategyType
        )
    }
}

typealias InstrumentCodable = InstrumentProtocol & Codable

// MARK: - Instrument Protocol
protocol InstrumentProtocol {
    var assetType: AssetType { get set }
    var cusip: String { get set }
    var symbol: Symbol { get set }
    var description: String { get set }
    // "instrument": "The type <Instrument> has the following subclasses [Equity, FixedIncome, MutualFund, CashEquivalent, Option] descriptions are listed below\"",
}

// MARK: - Instruments
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

// MARK: - Instrument subtypes
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
