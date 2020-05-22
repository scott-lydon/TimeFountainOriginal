//
//  EndPoints.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation



extension URL {
    
//    static func prefetchUser(for row: Int) -> URL {
//        return TDAmeritradeURL(path: "nearbyUser")
//        .apikey
//        .periodType()
//        .period
//            .row(row)
//            .build
//    }
    
    static var cancelOrder: URL? {
        return URL(string: .baseURL + "accounts/{accountId}/orders/{orderId}")
    }
    
    static var getOrdersByPath: URL? {
        return URL(string: .baseURL + "accounts/{accountId}/orders/{orderId}")
    }
    
    static var getOrdersByQuery: URL? {
        return URL(string: .baseURL + "orders")
    }
    
    static var placeOrder: URL? {
        return URL(string: .baseURL + "accounts/{accountId}/orders")
    }
    
    static var replaceOrder: URL? {
        return URL(string: .baseURL + "accounts/{accountId}/orders/{orderId}")
    }
    
    static var priceHistory: URL? {
        print(#line)
        guard let apikey = Bundle.td_api_key else { return nil }
        print(#line)
        let str: String = .baseURL + "marketdata/TSLA/pricehistory?apikey=" + apikey
        print(str)
        return URL(string: str)
    }
    
    static var instruments: URL? {
        return URL(string: .baseURL + "instruments")
    }
    
    static var instrumentsByCussip: URL? {
        return URL(string: .baseURL + "instruments/{cusip}")
    }
    
    static var movers: URL? {
        return URL(string: .baseURL + "marketdata/{index}/movers")
    }
    
    static var optionChains: URL? {
        return URL(string: .baseURL + "marketdata/chains")
    }
    
    static var account: URL? {
        return URL(string: .baseURL + "accounts/{number}")
    }

    static var hours: URL? {
        return URL(string: .baseURL + "marketdata/{market}/hours")
    }
    
    static var token: URL? {
        return URL(string: .baseURL + "oauth2/token")
    }
    
    static var quotes: URL? {
        return URL(string: .baseURL + "marketdata/{STOCK}/quotes")
    }
    
    static var transactions: URL? {
        return URL(string: .baseURL + "accounts/494547284/transactions")
    }
    
    static var preferences: URL? {
        return URL(string: .baseURL + "accounts/494547284/preferences")
    }
    
    static var subscriptionKey: URL? {
        return URL(string: .baseURL + "userprincipals/streamersubscriptionkeys")
    }
    
    static var userPrincipals: URL? {
        return URL(string: .baseURL + "userprincipals")
    }
        
    static var watchlist: URL? {
        return URL(string: .baseURL + "accounts/494547284/watchlists/{watchlistid}")
    }
    
    static var watchlists: URL? {
        return URL(string: .baseURL + "accounts/494547284/watchlists")
    }
    
    

}


