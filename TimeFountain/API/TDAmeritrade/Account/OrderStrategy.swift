//
//  OrderStrategy.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct OrderStrategy: Codable {
    let session, duration, orderType: String
    let cancelTime: CancelTime
    let complexOrderStrategyType: String
    let quantity, filledQuantity, remainingQuantity: Int
    let requestedDestination, destinationLinkName, releaseTime: String
    let stopPrice: Int
    let stopPriceLinkBasis, stopPriceLinkType: String
    let stopPriceOffset: Int
    let stopType, priceLinkBasis, priceLinkType: String
    let price: Int
    let taxLotMethod: String
    let orderLegCollection: [OrderLegCollection]
    let activationPrice: Int
    let specialInstruction, orderStrategyType: String
    let orderID: Int
    let cancelable, editable: Bool
    let status, enteredTime, closeTime, tag: String
    let accountID: Int
    let orderActivityCollection: [String]
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
