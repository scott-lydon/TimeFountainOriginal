//
//  URL+Factory.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    
    enum Path {
        case accounts, orders, marketdata, instruments, ticker(String), oauth2, userprincipals, watchlists, pricehistory, movers, chains, hours, token, quotes, transactions, preferences, streamersubscriptionkeys
    }
    
//    static func prefetchUser(for row: Int) -> URL {
//        return TDAmeritradeURL(path: "nearbyUser")
//        //  access_token_and_user_id()
//            .row(row)
//            .build
//    }
//    
//    static func prefetchQuestion(for row: Int) -> URL {
//        return TDAmeritradeURL(path: "question")
//        // .access_token_and_user_id()
//            .row(row)
//            .build
//    }
}
