//
//  ViewController.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ticker = "TSLA"
        let url = URL.priceHistory(
            period: .days(.ten, .oneMinute),
            ticker: ticker
        )
        print(url.absoluteString)
        url.getData { data in
            guard let candleList = CandleList(data),
                let dataframe = DataFrame([
                    DataFrame.Column(header: "date", cells: candleList.dates.asStrings),
                    DataFrame.Column(header: "close", cells: candleList.closes.asStrings),
                    DataFrame.Column(header: "SMA", cells: candleList.closes.sma(for: 180).asStrings)
                ]) else { return }
            print(dataframe.convertToCSV(subPathSlashesBetween: ticker + "/" + "priceHistory"))
        }

        
        
    }
}
