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
        URL(string: .baseURL + "accounts/{accountId}/orders/{orderId}")
    }
    
    static var getOrdersByPath: URL? {
        URL(string: .baseURL + "accounts/{accountId}/orders/{orderId}")
    }
    
    static var getOrdersByQuery: URL? {
        URL(string: .baseURL + "orders")
    }
    
    static var placeOrder: URL? {
        URL(string: .baseURL + "accounts/{accountId}/orders")
    }
    
    static var replaceOrder: URL? {
        URL(string: .baseURL + "accounts/{accountId}/orders/{orderId}")
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
        URL(string: .baseURL + "instruments")
    }
    
    static var instrumentsByCussip: URL? {
        URL(string: .baseURL + "instruments/{cusip}")
    }
    
    static var movers: URL? {
        URL(string: .baseURL + "marketdata/{index}/movers")
    }
    
    static var optionChains: URL? {
        URL(string: .baseURL + "marketdata/chains")
    }

    static var hours: URL? {
        URL(string: .baseURL + "marketdata/{market}/hours")
    }
    
    static var token: URL? {
        URL(string: .baseURL + "oauth2/token")
    }
    
    static var quotes: URL? {
        URL(string: .baseURL + "marketdata/{STOCK}/quotes")
    }
    
    static var transactions: URL? {
        // Separated in order to speed up compile checking. 
        let string: String = .baseURL + "accounts/" + .account_id + "/transactions"
        return URL(string: string)
    }
    
    static var preferences: URL? {
        URL(string: .baseURL + "accounts/" + .account_id + "/preferences")
    }
    
    static var subscriptionKey: URL? {
        return URL(string: .baseURL + "userprincipals/streamersubscriptionkeys")
    }
    
    static var userPrincipals: URL? {
        return URL(string: .baseURL + "userprincipals")
    }
        
    static var watchlist: URL? {
        return URL(string: .baseURL + "accounts/" + .account_id + "/watchlists/{watchlistid}")
    }
    
    static var watchlists: URL? {
        return URL(string: .baseURL + "accounts/" + .account_id + "/watchlists")
    }
    
    

}


