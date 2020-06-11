//
//  ViewController.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Cocoa
import CoreML
import Alamofire
import SwiftWebSocket


class ViewController: NSViewController {
    
    //    let model = TSLA()
    //    var manager: SocketManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.refreshTokenAction = { [weak self] in
            self?.viewDidLoadAndRefreshtokenIsReady()
        }
        if AppDelegate.refreshedToken {
            viewDidLoadAndRefreshtokenIsReady()
        }
    }
    
    func viewDidLoadAndRefreshtokenIsReady() {
        URL.stream(
            [.quotes(
                QuoteParams([.CBLI], fields: .Symbol, .Close_Price)
                )
            ]
        ) { message in
            guard let data = message.data(using: .utf8) else { return }
            if let error = ErrorResponses(data),
                let response = error.response.first {
                
                print(response.content.code != 21, "Login failed, Check that types are correct, for example, 30 should maybe be a string instead.")
                print(false, response.content.msg)
            }
        }
//        URL.stream(
//            .quotes(QuoteParams([.CBLI], fields: .Symbol, .Close_Price))
//        ) { message in
//            print(message)
////            guard let data = message.data(using: .utf8) else { return }
////            if let error = ErrorResponses(data) {
////                print("we got the error: \(error)")
////                if let response = error.response.first {
////                    print(response.content)
////                }
////            }
////            print("we have a quote.", message)
//        }
    }
    
    
    
    //---  var ws: WebSocket!
    // WORKS
    func echoTest(request: String){
        
        // --->>>>
        //        var messageNum = 0
        //        ws = WebSocket("wss://streamer-ws.tdameritrade.com/ws")
        //        let send : Action = {
        //            messageNum += 1
        //            let msg = "\(messageNum): \(NSDate().description)"
        //            print("send: \(msg)")
        //            self.ws.send(request)
        //        }
        //        ws.event.open = {
        //            print("opened")
        //            send()
        //        }
        //        ws.event.close = { code, reason, clean in
        //            self.echoTest(request: request)
        //            print("close", reason, "was clean: ", clean)
        //        }
        //        ws.event.error = { error in
        //            print("error \(error)")
        //        }
        //        ws.event.message = { message in
        //            print(message)
        //
        //            //            if let text = message as? String {
        //            //                print("recv: \(text)")
        //            //                if messageNum == 10 {
        //            //                  //  ws.close()
        //            //                } else {
        //            //                    send()
        //            //                }
        //            //            }
        //        }
    }
}




extension ViewController {
    // TODO: https://github.com/ndevenish/Site-ndevenish/blob/master/_posts/2017-04-11-using-python-with-swift-3.markdown
    
    
    fileprivate func callTeslaPriceHistory() {
        let ticker = "TSLA"
        let url = URL.priceHistory(
            period: .days(.ten, .oneMinute),
            ticker: ticker
        )
        print(url.absoluteString)
        url.getData { data in
            guard let candleList = CandleList(data),
                let dataframe = DataFrame(
                    DataFrame.Column(header: "date", cells: candleList.dates.asStrings),
                    DataFrame.Column(header: "close", cells: candleList.closes.asStrings),
                    DataFrame.Column(header: "SMA", cells: candleList.closes.sma(for: 180).asStrings)
                ) else { return }
            let csv = dataframe.convertToCSV(
                root: .desktopDirectory,
                named: ticker + "_" + Date().timeIntervalSince1970.string
            )
            print(csv?.absoluteString ?? "nil")
        }
    }
    
    func streamerSubscriptionKeys() {
        URLRequest.streamerSubscriptionKeys().getData { data in
            let keys = StreamerSubscriptionKeys(data)
            print(keys?.keys.first?.key ?? "nil")
        }
    }
    
    func testModel() {
        //        let prediction = try? model.prediction(close: 3.49, SMA: "3499")
        //        print(prediction?.date ?? "nil")
    }
    
//    typealias PrincipalAction = (UserPrincipals?)->Void
//    
//    func userPrincipals(action: @escaping PrincipalAction) {
//        
//        let prinicpalsReq = URLRequest.userprincipals(
//            fields: [
//                .preferences,
//                .streamerConnectionInfo,
//                .streamerSubscriptionKeys,
//                .surrogateIds,
//            ]
//        )
//        let key = "userPrincipals"
//        if let data = UserDefaults.standard.data(forKey: key) {
//            let principals = UserPrincipals(dataWithDate: data)
//            action(principals)
//        } else {
//            URLRequest.userprincipals(
//                fields: [
//                    .preferences,
//                    .streamerConnectionInfo,
//                    .streamerSubscriptionKeys,
//                    .surrogateIds,
//                ]
//            ).getData { data in
//                UserDefaults.standard.set(data, forKey: key)
//                let principals = UserPrincipals(dataWithDate: data)
//                action(principals)
//                //print(principals ?? "nil principals")
//            }
//            prinicpalsReq.get { json in
//                print("JSON: --->\n\n", json?.asJSON ?? "json was nil! :(", "\n\n<_____")
//                print("")
//            }
//        }
//    }
}
