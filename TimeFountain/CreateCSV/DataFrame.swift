//
//  DataFrame.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array {
    
    typealias DictAct = (Element)->(String, String?)
    
    func mapToDictionary(_ dictAct: DictAct) -> [String: String?] {
        var dict: [String:String?] = [:]
        for element in self {
            dict[dictAct(element).0] = dictAct(element).1
        }
        return dict
    }
}

struct DataFrame: Equatable {
    
    var lastRow: [String: String?] {
        columns.mapToDictionary { ($0.header, $0.cells.first ) }
    }
    
    init?(_ data: Data) {
        guard let candles = CandleList(data) else { return nil }
        self.init(
            .dates(candles.dates.asStrings),
            .closes(candles.closes.asStrings),
            .smas(candles.closes.sma(for: 180).asStrings)
        )
    }
    
    init?(_ candles: CandleList) {
        self.init(
            .dates(candles.dates.asStrings),
            .closes(candles.closes.asStrings),
            .smas(candles.closes.sma(for: 180).asStrings)
        )
    }
    
    func append(_ quote: StreamedQuote) {
        // TODO
    }
    
    static func == (lhs: DataFrame, rhs: DataFrame) -> Bool {
        return lhs.columns == rhs.columns
    }
    
    struct Column: Equatable {
        static func == (lhs: DataFrame.Column, rhs: DataFrame.Column) -> Bool {
            return lhs.header == rhs.header && lhs.cells == rhs.cells
        }
        var header: String
        var cells: [String]
        
        static func dates(_ dates: [String]) -> Column {
            Column(header: "date", cells: dates)
        }
        
        static func closes(_ closes: [String]) -> Column {
            Column(header: "close", cells: closes)
        }
        
        static func smas(_ smas: [String]) -> Column {
            Column(header: "SMA", cells: smas)
        }
        
        
    }
    
    var columns: [Column]
    
    init?(_ columns: [Column]) {
        guard columns.map({ $0.cells.count }).allEqual, columns.count > 0 else { return nil }
        self.columns = columns
    }
    
    init?(_ columns: Column...) {
        self.init(columns)
    }
    
    @discardableResult
    func convertToCSV(
        root: FileManager.SearchPathDirectory = .desktopDirectory,
        generalPath: String = "iOS/DataFrame/",
       // subPathSlashesBetween: String = "",
        named csvname: String = Int(Date().timeIntervalSince1970).description
    ) -> URL? {
        stringMatrix.asCSV.save(root: root, pathStr: generalPath + /*subPathSlashesBetween +*/ csvname + ".csv")
    }
    
    @discardableResult
    func convertToCSV(ticker: String) -> URL? {
        convertToCSV(named: ticker + "_" + Date().timeIntervalSince1970.string)
    }
    
    var stringMatrix: [[String]] {
        guard let height = columns.first?.cells.count else {
            print("cells are empty")
            return []
        }
        var rows: [[String]] = [
            columns.map({ $0.header }),
        ]
        for row in 0..<height {
            var rowArr: [String] = []
            for col in 0..<columns.count {
                rowArr.append(columns[col].cells[row].description)
            }
            rows.append(rowArr)
        }
        return rows
    }
}
