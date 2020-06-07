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
//import SwiftWebSocket
extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

class ViewController: NSViewController {
    
    //    let model = TSLA()
    //    var manager: SocketManager!
    
    let refreshTokenKey = "refreshToken"
    let accessTokenKey = "accessToken"
    override func viewDidLoad() {
        super.viewDidLoad()
       // testRefTokenAlamoFire()
        //print("\nBEARER: ", Keychain.loadFrom(key: accessTokenKey)!, "\n\n")
        placeOrderWithAlamofire()

    }
    
    /// WORKS
    func testRefTokenAlamoFire() {
        guard let accessToken = Keychain.loadFrom(key: accessTokenKey),
            let refreshToken = Keychain.loadFrom(key: refreshTokenKey) else { return }
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters = [
            "grant_type":"refresh_token",
            "refresh_token":refreshToken,
            "access_type":"offline",
            "client_id":"FMUIJZGTI7IV08OAEIMTXGA6Y9TNRYEJ"
        ]
        
        Alamofire.request(
            "https://api.tdameritrade.com/v1/oauth2/token",
            method: .post,
            parameters: parameters,
            encoding:  URLEncoding.default,
            headers: headers
        ).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success(let data):
                guard let data = response.data,
                    let token = Token(data) else { return }

                print("Path: ", String.credentialsPath)
                print("string dictionary: ", token.newCredentialsFileDictionary)
                print("string file: ", token.newCredentialsFileContent)
                Keychain.save(key: self.accessTokenKey, value: token.accessToken)
                Keychain.save(key: self.refreshTokenKey, value: token.refreshToken)
                print("success",data)
            case.failure(let error):
                print("Not Success",error)
                // self.view.makeToast(message: "Server Error!!")
            }
        }
    }
    
    /// WORKS
    func placeOrderWithAlamofire() {
        let purchaseRequest = BuyMarketStock(
            orderType: "MARKET",
            session: "NORMAL",
            duration: "DAY",
            orderStrategyType: "SINGLE",
            orderLegCollection: [
                OrderLegCollection(
                    instruction: "BUY",
                    quantity: 1,
                    instrument: Instrument(
                        symbol: "SNMP",
                        assetType: "EQUITY",
                        instrumentDescription: nil
                    )
                )
            ]
        )
        print("", purchaseRequest.stringified!)
        print("\n")
        let jsonObject = try? JSONSerialization.data(withJSONObject: purchaseRequest.dictionary, options: [])
        
        if let jsonString = String(data: jsonObject!, encoding: .utf8) {
            
            var headers: [String: String] = .forAccess()
            headers["Content-Type"] = "application/json"

//            Alamofire.request(
//                URL.placeOrder().absoluteString,
//                method: .post,
//                parameters: purchaseRequest.dictionary, encoding: JSONEncoding.default, headers:headers).validate()
//                .responseData { data in
//                    print(data.data)
//            }
            
            Alamofire.request(
                URL.placeOrder().absoluteString,
                method: .post,
                parameters: purchaseRequest.dictionary,
                encoding: JSONEncoding.default,
                headers:headers
            ).validate().responseData { data in
                print(#line, "data was: ", data.data)
                print(#line, "This was: ", data.result.value)
                var statusCode =  data.response?.statusCode
                print(statusCode)
                if let location = data.response?.allHeaderFields["Location"] as? String {
                    print(location)
                    Alamofire.request(
                        location,
                        method: .get,
                        encoding: JSONEncoding.default,
                        headers:headers
                    ).validate().responseJSON { (response:DataResponse<Any>) in
                        print(#line, "data was: ", response.result.value)
                    }
                }
            }
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
    
    func placeOrder() {
        let purchaseRequest = BuyMarketStock(
            orderType: "MARKET",
            session: "NORMAL",
            duration: "DAY",
            orderStrategyType: "SINGLE",
            orderLegCollection: [
                OrderLegCollection(
                    instruction: "BUY",
                    quantity: 1,
                    instrument: Instrument(
                        symbol: "SNMP",
                        assetType: "EQUITY",
                        instrumentDescription: nil
                    )
                )
            ]
        )
        let jsonObject = try? JSONSerialization.data(withJSONObject: purchaseRequest.dictionary, options: [])

        if let jsonString = String(data: jsonObject!, encoding: .utf8) {
            print(jsonString)
            var request = URLRequest(url: URL.placeOrder())
            request.allHTTPHeaderFields = [:]
            request.allHTTPHeaderFields?["Content-Type"] = "application/JSON"
            request.httpBody = jsonString.data(using: String.Encoding.utf8)
            print(request.allHTTPHeaderFields, "\n", URL.placeOrder(), "\n", jsonString)
            request.get { json in
                print(json)
            }
//            request.getData { data in
//
//            }
        }
//        URLRequest.placeOrder().getData { data in
//
//        }
    }
    
    /// TODO, not working yet.
    func accessToken() {
        let url = URL.accessToken()
        print(url.absoluteString)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = .forAccess()
        request.allHTTPHeaderFields?["Content-Type"] = "application/x-www-form-urlencoded"
        request.allHTTPHeaderFields?["Allow Header"] = "GET,POST,PUT,DELETE"
        request.method = .GET
        request.get { json in
            print("JSON was: ", json ?? "nil")
        }
    }
    
    func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    
    func refreshToken123()
    {
        let url = URL(string: "https://api.tdameritrade.com/v1/oauth2/token")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        
        let postString = "grant_type=refresh_token&refresh_token=\(String(describing: String.refreshTokenLiteral.fromCredentials.urlEncoded))&access_type=offline&code=&client_id=FMUIJZGTI7IV08OAEIMTXGA6Y9TNRYEJ"
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8)
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
    }
    
    func refreshCode() {
        let url: URL = URL(string: "https://api.tdameritrade.com/v1/oauth2/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params: [String: Any] = [
            "grant_type": "refresh_token",
            "refresh_token":String.refreshTokenLiteral.fromCredentials,
            "access_type": AccessType.offline.rawValue,
            "client_id": Bundle.td_api_key!
        ]
        let postString = getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)
        
        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        print("url is: ", url.absoluteString, "\nParams are: ", params, "\n\n")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if(error != nil)
            {
                result.message = "Fail Error not null : \(error.debugDescription)"
            }
            else
            {
                result.message = "Success"
                result.data = data
                print(data?.jsonDictionary)
            }
            
            
        }
        task.resume()
    }
    
    
    
    /// TODO, not working yet.
    func refreshToken() {
        let url: URL = .refreshToken()
        print(url.absoluteString)
        var request = URLRequest(url: .refreshToken())
        // request.allHTTPHeaderFields = .forAccess()
        request.allHTTPHeaderFields?["Content-Type"] = "application/x-www-form-urlencoded"
        // request.allHTTPHeaderFields?["Allow Header"] = "GET,POST,PUT,DELETE"
        let parameters: [String: Any] = [
            "grant_type": GrantType.refresh_token.rawValue,
            "refresh_token":String.refreshTokenLiteral.fromCredentials,
            "access_type": AccessType.offline.rawValue,
            "client_id": Bundle.td_api_key!
        ]
        print(parameters)
        print(parameters["client_id"])
        request.httpBody = parameters.percentEncoded()
        request.method = .POST
        request.get { json in
            print("JSON was: ", json)
        }
    }
    
    func tryAuth() {
        let url = URL.oauth2(
            grant_type: .authorization_code,
            access_type: .offline,
            code: Bundle.td_AccessToken,
            client_id: .account_id,
            redirect_uri: "http://localhost"
        )
        print(url.absoluteString)
        url.getData { data in
            let token = Token(data)
            print(token?.expiresIn, token?.accessToken, token?.refreshToken, token?.refreshTokenExpiresIn)
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
