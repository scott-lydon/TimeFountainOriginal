//
//  GetOrder.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

// Same as Order Strategy
struct OrderGet: Codable {
    let session: Session
    let duration: Duration
    let orderType: OrderType
    let complexOrderStrategyType: ComplexOrderStrategyType
    let quantity: Int
    let filledQuantity: Int
    let remainingQuantity: Int
    let requestedDestination: String
    let destinationLinkName: String
    let orderLegCollection: [OrderLegCollection]
    let orderStrategyType: OrderStrategyType
    let orderID: Int
    let cancelable: Bool
    let editable: Bool
    let status: Status
    let enteredTime: String
    let closeTime: String?
    let tag: String
    let accountID: Int
    let orderActivityCollection: [Execution]? 
    
    let replacingOrderCollection: [ChildOrderStrategy]?
    let childOrderStrategies: [ChildOrderStrategy]?
    let statusDescription: String?
    let cancelTime: CancelTime?
    let releaseTime: String?
    let stopPrice: Int?
    let stopPriceLinkBasis: StopPriceLinkBasis?
    let stopPriceLinkType: StopPriceLinkType?
    let stopPriceOffset: Int?
    let stopType: StopType?
    let priceLinkBasis: PriceLinkBasis?
    let priceLinkType: PriceLinkType?
    let price: Int?
    let taxLotMethod: TaxLotMethod?
    let activationPrice: Int?
    let specialInstruction: SpecialInstruction?

    enum CodingKeys: String, CodingKey {
        case session, duration, orderType, cancelTime, complexOrderStrategyType, quantity, filledQuantity, remainingQuantity, requestedDestination, destinationLinkName, releaseTime, stopPrice, stopPriceLinkBasis, stopPriceLinkType, stopPriceOffset, stopType, priceLinkBasis, priceLinkType, price, taxLotMethod, orderLegCollection, activationPrice, specialInstruction, orderStrategyType
        case orderID = "orderId"
        case cancelable, editable, status, enteredTime, closeTime, tag
        case accountID = "accountId"
        case orderActivityCollection, replacingOrderCollection, childOrderStrategies, statusDescription
    }
}
