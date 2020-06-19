//
//  URL+runBot.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/18/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    
    ///Continuous running bot. 
    static func runBot(
        ticker: String,
        quotes: @escaping (DataFrame, StreamedQuote) -> BuyMarketStock.Prediction,
        accountUpdate: @escaping (Account) -> Double,
        transaction: @escaping ConfirmAction
    ) {
        //1
        URL.priceHistories(ticker: ticker) { dataFrame in
            guard let dataFrame = dataFrame else { return }
            //2
            URL.streamQuotes(for: ticker) { quote in
                //3
                dataFrame.append(quote)
                //4
                let prediction = quotes(dataFrame, quote)
                
                // 5
                URLRequest.account() { account in
                    let allowance = accountUpdate(account)
                    // 6
                    URL.transactBased(
                        on: prediction,
                        with: allowance,
                        for: ticker,
                        marketValue: 99.0 // TODO get the estimated buy value from the quote
                    ) { confirmation in
                        transaction(confirmation)
                    }
                }
            }
        }
    }
    
    typealias DataFrameQuoteActionToDouble = (DataFrame, StreamedQuote) -> BuyMarketStock.Prediction
    typealias AccountAction = (Account)->Void
    
    ///Bot the a stopping point
    static func runBot(
        ticker: String,
        allowance: Double,
        closeTimeFromNow: Double,
        sellUponClose: Bool,
        dataFrameQuoteAction: @escaping DataFrameQuoteActionToDouble,
        accountUpdate: @escaping AccountAction,
        transaction: @escaping ConfirmationAction
    ) {
        
    }
}
