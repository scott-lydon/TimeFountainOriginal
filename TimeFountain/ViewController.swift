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

class ViewController: NSViewController {
    
    let model = TSLA()
    //    var manager: SocketManager!
    @IBOutlet weak var optionsTable: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.refreshTokenAction = { [weak self] in
            print(#line)
            self?.viewDidLoadAndRefreshtokenIsReady()
        }
        if AppDelegate.refreshedToken {
            print(#line)
            viewDidLoadAndRefreshtokenIsReady()
        }
    }
    
    func setDataFrames() {
        URL.finviz { symbols in
            symbols.forEach { ticker in
                URL.priceHistories(ticker: ticker) { dataFrame in
                    dataFrame?.convertToCSV(ticker: ticker)
                }
            }
        }
    }
        
    func runBot() {
        let model = TSLA()
        let ticker = String(describing: model.self)
        URL.runBot(ticker: ticker, quotes: { dataframe, quote in
          model.prediction(from: dataframe)
        }, accountUpdate: { account in
            print("Output account on screen:", account.currentBalances.availableFunds)
            return account.currentBalances.availableFunds - 25_000.00 // cashBalance, availableFunds savings
        }, transaction: { confirmation in
            print(confirmation)
        })
    }
    
    @IBAction func dataFramesTapped(_ sender: NSButtonCell) {
        setDataFrames()
    }
        
    func viewDidLoadAndRefreshtokenIsReady() {
        optionsTable.delegate = self
        optionsTable.dataSource = self
        setDataFrames()
    }
}

extension URL {
    
    static func runBot(
        ticker: String,
        quotes: @escaping (DataFrame, StreamedQuote) -> BuyMarketStock.Prediction,
        accountUpdate: @escaping (Account) -> Double,
        transaction: @escaping ConfirmAction
    ) {
        //1
        URL.priceHistories(ticker: ticker) { dataFrame in
            guard let dataFrame = dataFrame else { return }
            //2
            URL.streamQuotes(for: ticker) { quote in
                //3
                dataFrame.append(quote)
                //4
                let prediction = quotes(dataFrame, quote)
                
                // 5
                URLRequest.account() { account in
                    let allowance = accountUpdate(account)
                    // 6
                    URL.transactBased(
                        on: prediction,
                        with: allowance,
                        for: ticker,
                        marketValue: 99.0 // TODO get the estimated buy value from the quote
                    ) { confirmation in
                        transaction(confirmation)
                    }
                }
            }
        }
    }
}




extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    
}



extension ViewController {
    // TODO: https://github.com/ndevenish/Site-ndevenish/blob/master/_posts/2017-04-11-using-python-with-swift-3.markdown
    
    
    fileprivate func callHistory(for ticker: String) {
        let ticker = "TSLA"
        let url = URL.priceHistory(
            period: .days(.ten, .oneMinute),
            ticker: ticker
        )
        print(url.absoluteString)
        url.getData { data in
            guard let candleList = CandleList(data),
                let dataframe = DataFrame(candleList) else { return }
            let csv = dataframe.convertToCSV(
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

}
