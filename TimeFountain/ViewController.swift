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
        
        ["cat", "dog", "slippery"]
        
        guard let dataframe = DataFrame([
            DataFrame.Column(header: "date", cells: ["Monday", "Tuesday"]),
            DataFrame.Column(header: "Values", cells: [349.string, 34.string]),
        ]) else { return }
        print(dataframe.stringMatrix)
       // dataframe.asCSVString.save(root: .desktopDirectory, pathStr: "TestWorked2.csv")
        // Do any additional setup after loading the view.
    }
}
