//
//  authURL.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/28/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    
    // THIS IS ALL INVALID.
    // USE THIS GUIDE INSTEAD: https://medium.com/p/ed7cf9d97768/edit
    
    //https://youtu.be/sVA0PeuDE4I
    static func authToken(
        response_type: String = "code",
        redirect_uri: String = "ScottLydon.TimeFountain",
        client_id: String = Bundle.td_api_key! + "%40AMER.OAUTHAP"
    ) -> URL {
        return TDAmeritradeURL(authPath: .auth)
            .response_type(response_type)
            .redirect_uri(redirect_uri)
            .client_id(client_id)
            .build
    }
}


extension TDAmeritradeURL {
    
    
    func response_type(_ response_type: String) -> TDAmeritradeURL {
        return kv(.response_type, response_type)
    }
    
    func redirect_uri(_ redirect_uri: String) -> TDAmeritradeURL {
        return kv(.redirect_uri, redirect_uri)
    }
}
