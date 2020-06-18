//
//  OrderStrategy.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//
//
import Foundation

struct OrderStrategy: Codable {
    enum RequestedDestination: String, Codable {
        case INET, ECN_ARCA, CBOE, AMEX, PHLX, ISE, BOX, NYSE, NASDAQ, BATS, C2, AUTO
    }
    
    let session: Session
    let duration: Duration
    let orderType: OrderType
    let cancelTime: CancelTime
    let complexOrderStrategyType: ComplexOrderStrategyType
    let quantity, filledQuantity, remainingQuantity: Int
    let requestedDestination: RequestedDestination
    let destinationLinkName, releaseTime: String
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
    let cancelable, editable: Bool
    let status: Status
    let enteredTime, closeTime, tag: String
    let accountID: Int
    let orderActivityCollection: [Execution]
    let replacingOrderCollection, childOrderStrategies: [ChildOrderStrategy]
    let statusDescription: String

    enum CodingKeys: String, CodingKey {
        case session, duration, orderType, cancelTime, complexOrderStrategyType, quantity, filledQuantity, remainingQuantity, requestedDestination, destinationLinkName, releaseTime, stopPrice, stopPriceLinkBasis, stopPriceLinkType, stopPriceOffset, stopType, priceLinkBasis, priceLinkType, price, taxLotMethod, orderLegCollection, activationPrice, specialInstruction, orderStrategyType
        case orderID = "orderId"
        case cancelable, editable, status, enteredTime, closeTime, tag
        case accountID = "accountId"
        case orderActivityCollection, replacingOrderCollection, childOrderStrategies, statusDescription
    }
}
