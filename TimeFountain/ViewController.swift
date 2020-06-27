//  ViewController.swift
//  TimeFountain
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.

import Cocoa
import CoreML
import Alamofire

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    let model = TSLA()
    @IBOutlet weak var optionsTable: NSTableView!
    
    /// View did load
    func viewDidLoadAndRefreshtokenIsReady() {
        print(#line, ":", Int())
        optionsTable.delegate = self
        optionsTable.dataSource = self
        setDataFrames()
    }
    
    func setDataFrames() {
        URL.finviz { symbols in
            let firstOne = URL.priceHistories(tickers: ["TSLA"]).first
            firstOne?.getData { data in
                guard let candleList = CandleList(data) else {
                    return
                }
                print(data.serialized)
                assert(!candleList.candles.isEmpty, "")
                guard let dataframe = DataFrame(candleList) else {
                    return
                }
                let csvPath = dataframe.save(ticker: "TSLA.test")
               // let csvpath = dataframe
               // print(csvPath)
               // print(csvPath.absoluteString, csvPath.relativePath)
               // print(csvPath.absoluteString, csvPath.relativePath)
                //                URL.priceHistories(ticker: ticker) { dataFrame in
                //                    dataFrame?.convertToCSV(ticker: ticker)
                //                }
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
            print(confirmation ?? "nil")
        })
    }
    
    @IBAction func dataFramesTapped(_ sender: NSButtonCell) {
        setDataFrames()
    }
}


extension ViewController {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return nil
    }
}
