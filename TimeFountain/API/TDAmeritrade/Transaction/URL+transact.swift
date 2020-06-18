//
//  URL+transact.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/18/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    
    typealias ConfirmAction = (OrderGet?) -> Void
    
    static func transactBased(
        on prediction: BuyMarketStock.Prediction,
        with allowance: Double,
        for ticker: String,
        marketValue: Double,
        apiKey: String? = Bundle.td_api_key,
        confirmationAction: @escaping ConfirmAction
    )  {
        guard prediction.direction != .level else {
            confirmationAction(nil)
            return
        }
        guard let order = BuyMarketStock(
            ticker: ticker,
            prediction: prediction,
            allowance: allowance,
            marketValue: marketValue) else {
                confirmationAction(nil)
                return
                
        }
        URL.place(order: order) { confirmation in
            confirmationAction(confirmation)
        }
    }
}

extension BuyMarketStock {
    init?(
        ticker: String,
        prediction: BuyMarketStock.Prediction,
        allowance: Double,
        marketValue: Double
    ) {
        guard let instruction = Instruction(prediction.direction) else { return nil }
        /// not tested TODO
        self.init(
            orderType: .MARKET,
            session: .NORMAL,
            duration: .DAY,
            orderStrategyType: .SINGLE,
            orderLegCollection: [
                OrderLegCollection(
                    instruction: instruction,
                    quantity: Int(floor(allowance / marketValue)),
                    instrument: .init(
                        symbol: ticker,
                        assetType: .EQUITY,
                        instrumentDescription: nil
                    )
                )
            ]
        )
    }
}
