//
//  EndPoints.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    static var cancelOrder: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/accounts/{accountId}/orders/{orderId}")
    }
    
    static var getOrdersByPath: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/accounts/{accountId}/orders/{orderId}")
    }
    
    static var getOrdersByQuery: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/orders")
    }
    
    static var placeOrder: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/accounts/{accountId}/orders")
    }
    
    static var replaceOrder: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/accounts/{accountId}/orders/{orderId}")
    }
    
    static var priceHistory: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/marketdata/{symbol}/pricehistory")
    }
    
    static var instruments: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/instruments")
    }
    
    static var instrumentsByCussip: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/instruments/{cusip}")
    }
    
    static var movers: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/marketdata/{index}/movers")
    }
    
    static var optionChains: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/marketdata/chains")
    }
    
    static var account: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/accounts/{number}")
    }

    static var hours: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/marketdata/{market}/hours")
    }
    
    static var token: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/oauth2/token")
    }
    
    static var token: URL? {
        return URL(string: "https://api.tdameritrade.com/v1/marketdata/{STOCK}/quotes")
    }
    
    
    
   
    
}


