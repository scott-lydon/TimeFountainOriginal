//
//  TDSocketURL.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/2/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    
    static func tdSocket(
        principals: UserPrincipals
    ) -> URL?  {
        // https://developer.tdameritrade.com/content/streaming-data#_Toc504640574
        URL(string: "wss://" + principals.streamerInfo.streamerSocketURL + "/ws")
        // var mySock = new WebSocket("wss://" + userPrincipalsResponse.streamerInfo.streamerSocketUrl + "/ws");
        // mySock.onmessage = function(evt) { console.log(evt.data); }; mySock.onclose = function() { console.log("CLOSED"); };
         // mySock.send(JSON.stringify(request));
    }
}

