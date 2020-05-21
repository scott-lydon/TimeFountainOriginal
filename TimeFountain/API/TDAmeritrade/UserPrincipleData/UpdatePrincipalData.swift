//
//  UpdatePrincipalData.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct UpdatePrincipalData: Codable {
    let expressTrading, directOptionsRouting, directEquityRouting: Bool
    let defaultEquityOrderLegInstruction, defaultEquityOrderType, defaultEquityOrderPriceLinkType, defaultEquityOrderDuration: String
    let defaultEquityOrderMarketSession: String
    let defaultEquityQuantity: Int
    let mutualFundTaxLotMethod, optionTaxLotMethod, equityTaxLotMethod, defaultAdvancedToolLaunch: String
    let authTokenTimeout: String
}
