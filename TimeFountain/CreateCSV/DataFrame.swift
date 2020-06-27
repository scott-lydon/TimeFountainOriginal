//
//  DataFrame.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import AppKit

extension Array {
    
    typealias DictAct = (Element) -> (String, String?)
    
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
        self.init(candles)
    }
    
    init?(_ candles: CandleList) {
        self.init(
            .dates(candles.timestamps.asStrings),
            .closes(candles.closes.asStrings),
            .smas(candles.closes.sma(for: 180).asStrings),
            .ticker(Array(repeating: candles.symbol, count: candles.candles.count)),
            .sMAEMACrossed(candles.closes),
            .dayOfWeek(candles.dates),
            .hourOfDay(candles.dates),
            .month(candles.dates),
            .minutesOfHour(candles.dates),
            .supportResistancesEMASMA(candles.closes),
            .twoCandleTrends(candles.candles),
            .oneCandleTrends(candles.candles),
            .breakOuts(candles.candles),
            .macdIndicators(candles.closes),
            .macdReversals(candles.closes),
            .rsiIndicators(candles.closes),
            .simpleRisIndicators(candles.closes),
            .simpleVwapIndicators(candles.candles),
            .shapes(candles.candles, offset: 0),
            .shapes(candles.candles, offset: 1),
            .shapes(candles.candles, offset: 2),
            .shapes(candles.candles, offset: 3),
            .shapes(candles.candles, offset: 4),
            .shapes(candles.candles, offset: 5)
        )
    }
    
    func append(_ quote: StreamedQuote) {
        // TODO
    }
    
    static func == (lhs: DataFrame, rhs: DataFrame) -> Bool {
        lhs.columns == rhs.columns
    }
    
    struct Column: Equatable {
        
        static func == (lhs: DataFrame.Column, rhs: DataFrame.Column) -> Bool {
            lhs.header == rhs.header && lhs.cells == rhs.cells
        }
        
        var header: String
        var cells: [String]
        
        static func dates(_ dates: [String]) -> Column {
            Column(header: "date", cells: dates)
        }
        
        static func closes(_ closes: [String]) -> Column {
            Column(header: "close", cells: closes)
        }
        
        static func ticker(_ tickers: [String]) -> Column{
            Column(header: "Ticker", cells: tickers)
        }
        
        static func smas(_ smas: [String]) -> Column {
            Column(header: "SMA", cells: smas)
        }
        
        //crosses(emas: [Double?], smas: [Double?]) -> [SMAEMACrossed?] 
        static func sMAEMACrossed(_ closes: [Double], for range: Int = 180, smoothing: Int = 2, excludesurrent: Bool = false) -> Column {
            Column(header: "SMA EMA Crossed", cells: closes.crosses(for: range, smoothing: smoothing, excludesCurrent: excludesurrent).map { $0?.rawValue  ?? "nil"})
        }
        
        static func dayOfWeek(_ dates: [Date]) -> Column {
            //Column(header: "date", cells: dates)
            Column(header: "Day", cells: dates.map { $0.day })
        }
        
        static func hourOfDay(_ dates: [Date]) -> Column {
            Column(header: "Hour", cells: dates.map { $0.hour })
        }
        
        static func month(_ dates: [Date]) -> Column {
            Column(header: "Month", cells: dates.map { $0.month })
        }

        
        static func minutesOfHour(_ dates: [Date]) -> Column {
            Column(header: "Hour Quarter", cells: dates.map { $0.minutes?.rawValue ?? "nil" })
        }
        
        static func supportResistancesEMASMA(_ closes: [Double]) -> Column {
            Column(
                header: "Ema sma support resistance",
                cells: closes.supportResistancesEMASMA().map { $0?.rawValue ?? "nil" }
            )
        }
                
        static func twoCandleTrends(_ candles: [Candle]) -> Column {
            Column(header: "Two Candle Trend", cells: candles.trends.map { $0?.string ?? "nil" })
        }
        
        static func oneCandleTrends(_ candles: [Candle]) -> Column {
            Column(header: "Once Candle Trend", cells: candles.map { Trend($0.slope).string })
        }
             
        static func breakOuts(_ candles: [Candle]) -> Column {
            Column(header: "breakout", cells: candles.breakOuts().map { $0?.rawValue ?? "nil" })
        }
             
        static func macdIndicators(_ closes: [Double], fast: Int = 12, slow: Int = 26, length: Int = 9, smoothing: Int = 2) -> Column {
            Column(header: "MACD intersection", cells: closes.macdIndicators(fast: fast, slow: slow, length: length, smoothing: smoothing).map { $0?.rawValue ?? "nil"})
        }
        
        static func macdReversals(_ closes: [Double], fast: Int = 12, slow: Int = 26, length: Int = 9, smoothing: Int = 2) -> Column {
            Column(header: "MACD reversal", cells: closes.macdReversals(fast: fast, slow: slow, length: length, smoothing: smoothing).map { $0?.rawValue ?? "nil"})
        }
        
        static func rsiIndicators(_ closes: [Double], length: Int = 2) -> Column {
            Column(header: "RSI", cells: closes.risIndicators(length: length).map { $0?.rawValue ?? "nil"})
        }
        
        static func simpleRisIndicators(_ closes: [Double], length: Int = 2) -> Column {
            Column(header: "Simple RSI", cells: closes.simpleRisIndicators(length: length).map { $0?.rawValue ?? "nil" })
        }
        
        static func simpleVwapIndicators(_ candles: [Candle]) -> Column {
            Column(
                header: "Simple VWAP",
                cells: candles.simpleVwapIndicators().map { $0?.rawValue ?? "nil" }
            )
        }
        
        
        static func shapes(_ candles: [Candle], offset: Int = 0) -> Column {
            var arr: [String] = Array(repeating: "nil", count: offset) + candles.shapes.map { $0.rawValue }
            arr.removeLast(offset)
            return Column(header: "Candle shapes -\(offset.string)", cells: arr)
        }
    }
    
    var columns: [Column]
    
    init?(_ columns: [Column]) {
        guard columns.map({ $0.cells.count }).allEqual, columns.count > 0 else {
            print(columns.map {
                print($0.header, ": ", $0.cells.count)
            })
            return nil
        }
        self.columns = columns
    }
    
    init?(_ columns: Column...) {
        self.init(columns)
    }

    func save(ticker: String) -> String {
        //stringMatrix.asCSV.save(path: .localPath(ticker: ticker))
      //  let url = stringMatrix.asCSV.save(root: .desktopDirectory, pathStr: "terstmkjj.csv")
        stringMatrix.asCSV.createCSV(ticker: ticker)
       // print(url.absoluteString)
        return ""
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

enum Quarter: String {
    case first, second, third, fourth
}

extension Date {
    
    var minutes: Quarter? {
        let minuteCount = Calendar.current.component(.minute, from: self)
        if 0...15 ~= minuteCount {
            return .first
        } else if 15...30 ~= minuteCount {
            return .second
        } else if 30...45 ~= minuteCount {
            return .third
        } else if 45...60 ~= minuteCount {
            return .fourth
        } else {
            return nil
        }
    }
    
    var hour: String {
        String(Calendar.current.component(.hour, from: Date()))
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: self) - 1]
    }
}
