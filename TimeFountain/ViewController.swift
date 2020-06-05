//
//  ViewController.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Cocoa
import CoreML
import SwiftWebSocket

class ViewController: NSViewController {
    
    //    let model = TSLA()
    //    var manager: SocketManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //streamMagic()
        tryAuth()
    }
    
    func tryAuth() {
        let url = URL.oauth2(
            grant_type: .authorization_code,
            access_type: .offline,
            code: Bundle.td_AccessToken,
            client_id: "494547284",
            redirect_uri: "http://localhost"
        )
        print(url.absoluteString)
        url.getData { data in
            let token = Token(data)
            print(token?.expiresIn, token?.accessToken, token?.refreshToken, token?.refreshTokenExpiresIn)
        }
    }
    
    func streamMagic() {
        userPrincipals { principals in
            guard let principals = principals else { return }
            guard let url = URL(string: "wss://" + principals.streamerInfo.streamerSocketURL + "/ws") else { return }
            //self.socketIO(principals: principals, urlStr: url)
            //self.swiftSocket(principals: principals, urlStr: url)
            
            
            let req: [String: Any] = [
                "service": "QUOTE",
                "requestid": "2",
                "command": "SUBS",
                "account": principals.accounts!.first!.accountID,
                "source": principals.streamerInfo.appID,
                "parameters": [
                    "keys": "GOOG",
                    "fields": "0,1,2,3,4,5"
                ]
            ]
            
            var requests = principals.loginRequestDictionary
            if var rs = requests["requests"] as? [[String: Any]] {
                rs.append(req)
                requests["requests"] = rs as Any
            }
            print("requests: \n\n", requests, "\n\n<---")
            guard let requestQuerystr = requests.stringified else { return }
            print("request Stringified: \n\n", requestQuerystr, "\n\n<----")
            self.echoTest(request: requestQuerystr)
            print(requests)
            
            //            guard let news = requests.stringified else { return }
            //            print("news: -->\n\n", news, "\n\n<----")
            //            self.echoTest(login: requestStr, strings: [news])
            //            sleep(5)
            
            
        }
    }
    
    var ws: WebSocket!
    
    func echoTest(request: String){
        
        
        var messageNum = 0
        ws = WebSocket("wss://streamer-ws.tdameritrade.com/ws")
        let send : Action = {
            messageNum += 1
            let msg = "\(messageNum): \(NSDate().description)"
            print("send: \(msg)")
            self.ws.send(request)
        }
        ws.event.open = {
            print("opened")
            send()
        }
        ws.event.close = { code, reason, clean in
            self.echoTest(request: request)
            print("close", reason, "was clean: ", clean)
        }
        ws.event.error = { error in
            print("error \(error)")
        }
        ws.event.message = { message in
            print(message)

            //            if let text = message as? String {
            //                print("recv: \(text)")
            //                if messageNum == 10 {
            //                  //  ws.close()
            //                } else {
            //                    send()
            //                }
            //            }
        }
    }
    //
    //    func socketIO(principals: UserPrincipals, urlStr: URL) {
    //        self.manager = SocketManager(socketURL: urlStr, config: [.log(true),.compress])
    //        let socket = self.manager.defaultSocket
    //        socket.on(clientEvent: .connect) { data, ack in
    //            print("socket connected")
    //        }
    //    }
    //
    //    func swiftSocket(principals: UserPrincipals, urlStr: URL) {
    //        let client = TCPClient(address: urlStr.absoluteString, port: 8080)
    //        switch client.connect(timeout: 10) {
    //        case .success:
    //            print("successfully connected")
    //        case .failure(let err):
    //            print("Failed to connect with error: ", err.localizedDescription, "For url: ", urlStr.absoluteString)
    //        }
    //    }
    //
    //    func testConnect() {
    //        let client = TCPClient(address: "wss://streamer-ws.tdameritrade.com/ws", port: 8080)
    //        switch client.connect(timeout: 10) {
    //        case .success:
    //            print("successfully connected")
    //        case .failure(let err):
    //            print("Failed to connect with error: ", err.localizedDescription, "For url: ", "wss://streamer-ws.tdameritrade.com/ws")
    //        }
    //    }
    
    func testRayWanderMethod() {
        let socket = Socket()
        socket.messageAction = { message in
            print("connected")
        }
        socket.setupNetworkCommunication(address: "wss://streamer-ws.tdameritrade.com/ws", port: 8080)
        
        
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
    
    typealias PrincipalAction = (UserPrincipals?)->Void
    
    func userPrincipals(action: @escaping PrincipalAction) {
        
        let prinicpalsReq = URLRequest.userprincipals(
            fields: [
                .preferences,
                .streamerConnectionInfo,
                .streamerSubscriptionKeys,
                .surrogateIds,
            ]
        )
        let key = "userPrincipals"
        if let data = UserDefaults.standard.data(forKey: key) {
            let principals = UserPrincipals(dataWithDate: data)
            action(principals)
        } else {
            prinicpalsReq.getData { data in
                UserDefaults.standard.set(data, forKey: key)
                let principals = UserPrincipals(dataWithDate: data)
                action(principals)
                //print(principals ?? "nil principals")
            }
            prinicpalsReq.get { json in
                print("JSON: --->\n\n", json?.asJSON ?? "json was nil! :(", "\n\n<_____")
                print("")
            }
        }
    }
    
    func didRefresh(_ accessToken: String) {
        
    }
}
