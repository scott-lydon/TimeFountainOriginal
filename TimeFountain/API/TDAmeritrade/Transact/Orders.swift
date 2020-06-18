//
//  Orders.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/8/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

protocol Order: Codable {}

// MARK: - These are used VV
// MARK: - ORDERS in USE
struct BuyMarketStock: Order {
    
    struct Prediction {
        var direction: Direction
        var percentile: Percentile
        
        enum Direction {
            case goingUp, goingDown, level
        }
            
        /// Magnitude
        enum Percentile {
            case lowerTen, lowerTwenty, lowerThirty, lowerForty, lowerFifty, upperFifty, upperSixty, upperSeventy, upperEighty, upperNinety
        }
    }
    
    let orderType: OrderType
    let session: Session
    let duration: Duration
    let orderStrategyType: OrderStrategyType
    let orderLegCollection: [OrderLegCollection]
    
    init(orderType: OrderType, session: Session, duration: Duration, orderStrategyType: OrderStrategyType, orderLegCollection: [OrderLegCollection]) {
        self.orderType = orderType
        self.session = session
        self.duration = duration
        self.orderStrategyType = orderStrategyType
        self.orderLegCollection = orderLegCollection
    }
    
    init(ticker: String, quantity: Int) {
        self = BuyMarketStock(
            orderType: .MARKET,
            session: .NORMAL,
            duration: .DAY,
            orderStrategyType: .SINGLE,
            orderLegCollection: [
                OrderLegCollection(
                    instruction: .BUY,
                    quantity: quantity,
                    instrument: PurchaseInstrument(
                        symbol: ticker,
                        assetType: .EQUITY,
                        instrumentDescription: nil
                    )
                )
            ]
        )
    }
}

// MARK: - OrderLegCollection
struct OrderLegCollection: Order {
    let instruction: Instruction
    let quantity: Int
    let instrument: PurchaseInstrument
}

// MARK: - BuyLimitSingleOption
struct BuyLimitSingleOption:  Order {
    let complexOrderStrategyType: ComplexOrderStrategyType
    let orderType: OrderType
    let session: Session
    let price: String
    let duration: Duration
    let orderStrategyType: OrderStrategyType
    let orderLegCollection: [OrderLegCollection]
}

// MARK: - BuyLimitVerticalCallSpread
struct BuyLimitVerticalCallSpread: Order {
    let orderType: OrderType
    let session: Session
    let price: String
    let duration: Duration
    let orderStrategyType: OrderStrategyType
    let orderLegCollection: [OrderLegCollection]
}

// MARK: - CustomOptionSpread
struct CustomOptionSpread: Order {
    let orderStrategyType: OrderStrategyType
    let orderType: OrderType
    let orderLegCollection: [OrderLegCollection]
    let complexOrderStrategyType: ComplexOrderStrategyType
    let duration: Duration
    let session: Session
}

// MARK: - ConditionalOrder
struct ConditionalOrder: Order {
    let orderType: OrderType
    let session: Session
    let price: String
    let duration: Duration
    let orderStrategyType: OrderStrategyType
    let orderLegCollection: [OrderLegCollection]
    let childOrderStrategies: [ConditionalOrder]?
}

// MARK: - ConditionalCancelOrder
struct ConditionalCancelOrder: Order {
    let orderStrategyType: OrderStrategyType
    let childOrderStrategies: [ChildOrderStrategy]
}


// MARK: - ChildOrderStrategy
struct ChildOrderStrategy: Order {
    let orderStrategyType: OrderStrategyType
    let orderLegCollection: [OrderLegCollection] = []
    let childOrderStrategies: [DoubleTrigger] = []
    let stopPrice: String?
    let orderType: OrderType?
    let session: Session?
    let price: String?
    let duration: Duration?
}


// MARK: - DoubleTrigger
struct DoubleTrigger: Order {
    let orderStrategyType: OrderStrategyType
    let session: Session
    let duration: Duration
    let orderType: OrderType
    let price: Double?
    let orderLegCollection: [OrderLegCollection]
    let childOrderStrategies: [ChildOrderStrategy]?
    let stopPrice: Double?
}

// MARK: - SellTrailing
struct SellTrailing: Order {
    let complexOrderStrategyType: ComplexOrderStrategyType
    let orderType: OrderType
    let session: Session
    let stopPriceLinkBasis: StopPriceLinkBasis
    let stopPriceLinkType: StopPriceLinkType
    let stopPriceOffset: Int
    let duration: Duration
    let orderStrategyType: OrderStrategyType
    let orderLegCollection: [OrderLegCollection]
}
