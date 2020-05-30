//
//  ViewController.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Cocoa
import CoreML

class ViewController: NSViewController {

    let model = TSLA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print("\n\n")
        

        
//        let prediction = try? model.prediction(close: 3.49, SMA: "3499")
//        print(prediction?.date)
//
//        let principalsURL = URL.userPrincipals(.streamerConnectionInfo, .streamerSubscriptionKeys)

    }
}














extension ViewController {
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
            let csv = dataframe.convertToCSV(root: .desktopDirectory, named: ticker + "_" + Date().timeIntervalSince1970.string)
            print(csv?.absoluteString ?? "nil")
        }
    }
}
