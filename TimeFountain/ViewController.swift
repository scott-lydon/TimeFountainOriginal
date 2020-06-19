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
    
    func viewDidLoadAndRefreshtokenIsReady() {
        optionsTable.delegate = self
        optionsTable.dataSource = self
        setDataFrames()
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
            print(confirmation ?? "nil")
        })
    }
    
    @IBAction func dataFramesTapped(_ sender: NSButtonCell) {
        setDataFrames()
    }
}
