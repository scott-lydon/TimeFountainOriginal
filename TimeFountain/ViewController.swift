//
//  ViewController.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Cocoa
import CoreML


struct Stream: Codable {
    let requests: [Request]
}

struct Request: Codable {
    let service, requestid, command, account: String
    let source: String
    let parameters: Parameters
}

struct Parameters: Codable {
    let keys, fields: String
}


class ViewController: NSViewController {

    let model = TSLA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stream = Stream(
            requests: [
                Request(
                    service: "ACCT_ACTIVITY",
                    requestid: "2",
                    command: "SUBS",
                    account: "your_account",
                    source: "your_source_id",
                    parameters: Parameters(
                        keys: "af9997149e43afba25d5a0050e16637d6c24c3493e911161bd7dd017a6f00b4f5",
                        fields: "0,1,2,3"
                    )
                )
            ]
        )
    }
}
    


/*
 {
     "requests": [
         {
             "service": "ACCT_ACTIVITY",
             "requestid": "2",
             "command": "SUBS",
             "account": "your_account",
             "source": "your_source_id",
             "parameters": {
                 "keys": " af9997149e43afba25d5a0050e16637d6c24c3493e911161bd7dd017a6f00b4f5",
                 "fields": "0,1,2,3"
             }
         }
     ]
 }
 */


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
        let prediction = try? model.prediction(close: 3.49, SMA: "3499")
        print(prediction?.date ?? "nil")
    }
    
    func userPrincipals() {
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
            print(principals?.firstAccountCredentials)
        } else {
            prinicpalsReq.getData { data in
               // UserDefaults.standard.set(data, forKey: key)
                let principals = UserPrincipals(dataWithDate: data)
                print(principals ?? "nil principals")
            }
            prinicpalsReq.get { json in
                print(json?.asJSON ?? "json was nil! :(")
            }
        }
    }
    
    func didRefresh(_ accessToken: String) {
        
    }
}
