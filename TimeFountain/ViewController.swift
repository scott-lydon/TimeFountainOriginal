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
    
    //    let model = TSLA()
    //    var manager: SocketManager!
    
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
    
    func viewDidLoadAndRefreshtokenIsReady() {
        URL.finviz { symbols in
            
        }
//        URL.finviz { symbols in
//            let group = DispatchGroup()
//            group.enter(symbols.count)
//            group.notify(queue: DispatchQueue.main) {
//                print("We reached it")
//            }
//            symbols.forEach {_ in
//                URL.saveHistory(for: symbols, back: 36) {
//                    group.leave()
//                }
//            }
//        }
    }
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
