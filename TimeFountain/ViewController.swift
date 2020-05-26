//
//  ViewController.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/16/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import UIKit
import ScottLydon

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        URL.priceHistory(
            period: .days(.ten,.fiveMinutes),
            ticker: "TSLA"
        ).getData { data in
            
            print(CandleList(data) ?? "nil")
        }
        
        
        // Get the algorithms fro tos
        
        
        
        
    
        
        print(Bundle.tdAccount_id ?? "nil")
        print(Bundle.td_api_key ?? "nil")
        print("passed it...")
    }
}


