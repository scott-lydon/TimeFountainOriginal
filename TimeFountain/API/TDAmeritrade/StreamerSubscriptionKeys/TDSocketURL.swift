//
//  TDSocketURL.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/2/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import SwiftWebSocket

extension URL {
    
    static var ws: WebSocket?
    
    /// Main interface for streaming.
    static func stream<T: Decodable>(_ postLoginRequestsParts: Request.Parts..., action: @escaping (T)->Void) {
        URL.stream(postLoginRequestsParts, action: action)
    }
    
    /// Main interface for streaming.
    static func stream<T: Decodable>(_ postLoginRequestsParts: [Request.Parts], action: @escaping (T)->Void) {
        URL.userPrincipals { principals in
            guard let principals = principals,
                let stream = TDStream(principals: principals, requests: postLoginRequestsParts) else { return }
            URL.stream(stream, action: action)
        }
    }
    
    private static func stream<T: Decodable>(_ stream: TDStream, action: @escaping (T)->Void) {
        guard let stream = stream.stringified else { return }
        URL.stream(stream, action: action)
    }
    
    /// Used for debugging with direct string.
    static func stream<T: Decodable>(_ stream: String, action: @escaping (T)->Void) {
        var messageNum = 0
        
        ws = WebSocket("wss://streamer-ws.tdameritrade.com/ws")
        /// Hold a reference?
        let send : Action = {
            messageNum += 1
            let msg = "\(messageNum): \(NSDate().description)"
            print("send: \(msg)")
            self.ws?.send(stream)
        }
        ws?.event.open = {
            print("opened")
            send()
        }
        ws?.event.close = { code, reason, clean in
            URL.stream(stream, action: action)
            print("close", reason, "was clean: ", clean)
        }
        ws?.event.error = { error in
            print("error \(error)")
        }
        ws?.event.message = { message in
            print(message)
            //            if let text = message as? String {
            //                print("recv: \(text)")
            //                if messageNum == 10 {
            //                    //  ws.close()
            //                } else {
            //                    send()
            //                }
            //            }
        }
    }
    
    /// /// Good for debugging response handling.  Pure response is returned.
    static func stream(_ postLoginRequestsParts: Request.Parts..., action: @escaping StringAction) {
        URL.stream(postLoginRequestsParts, action: action)
    }
    
    /// /// Good for debugging response handling.  Pure response is returned.
    static func stream(
        _ postLoginRequestsParts: [Request.Parts],
        action: @escaping StringAction
    ) {
        URL.userPrincipals { principals in
            print(action)
            guard let principals = principals,
                let stream = TDStream(
                    principals: principals,
                    requests: postLoginRequestsParts
                ) else { return }
           // print("stream url: ", stream.)
            URL.stream(stream, action: action)
        }
    }
    
    private static func stream(_ stream: TDStream, action: @escaping StringAction) {
        guard let stream = stream.dictionary.asJSON else { return }
        print(stream)
        URL.stream(stream, action: action)
    }
    
    
    /// Good for debugging response handling.  Pure response is returned.
    static func stream(_ stream: String, action: @escaping StringAction) {
        var messageNum = 0
        
        ws = WebSocket("wss://streamer-ws.tdameritrade.com/ws")
        /// Hold a reference?
        let send : Action = {
            messageNum += 1
            let msg = "\(messageNum): \(NSDate().description)"
            print("send: \(msg)")
            self.ws?.send(stream)
        }
        ws?.event.open = {
            print("opened")
            send()
        }
        ws?.event.close = { code, reason, clean in
            URL.stream(stream, action: action)
            print("close", reason, "was clean: ", clean)
        }
        ws?.event.error = { error in
            print("error \(error)")
        }
        ws?.event.message = { message in
            print(message)
            if let message = message as? String {
                print(action)
                action(message)
                //                if messageNum >= 10 {
                //                    ws?.close()
                //                } else {
                //                     send()
                //                }
            } else {
                print("ERROR: Could not convert the message into a string in \(#file), line: \(#line)")
            }
        }
    }
    
    /// combined test non-working completion handler
    static func streamWithPrincipal(_ postLoginRequestsParts: [Request.Parts], action: @escaping StringAction) {
        var messageNum = 0
        ws = WebSocket("wss://streamer-ws.tdameritrade.com/ws")
        
        //action("Hi we work from here...")
        URL.userPrincipals { principals in
            print(action)
            guard let principals = principals,
                let stream = TDStream(principals: principals, requests: postLoginRequestsParts) else { return }
            URL.stream(stream) { message in
                /// Hold a reference?
                let send : Action = {
                    messageNum += 1
                    let msg = "\(messageNum): \(NSDate().description)"
                    print("send: \(msg)")
                    self.ws?.send(stream)
                }
                ws?.event.open = {
                    print("opened")
                    send()
                }
                ws?.event.close = { code, reason, clean in
                    URL.stream(stream, action: action)
                    print("close", reason, "was clean: ", clean)
                }
                ws?.event.error = { error in
                    print("error \(error)")
                }
                ws?.event.message = { message in
                    print(message)
                    if let message = message as? String {
                        print(action)
                        action(message)
                        //                if messageNum >= 10 {
                        //                    ws?.close()
                        //                } else {
                        //                     send()
                        //                }
                    } else {
                        print("ERROR: Could not convert the message into a string in \(#file), line: \(#line)")
                    }
                }
            }
        }
    }
    
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

