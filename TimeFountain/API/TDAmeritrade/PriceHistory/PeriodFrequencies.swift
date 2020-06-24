//
//  PeriodFrequencies.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array where Element == URL {
    
    typealias Enumerate = (Int, URL, Data) -> Void
    
    func callEnumerations(
        waitTime: Double = 0,
        expressive: Bool = false,
        enumerateCall: @escaping Enumerate,
        finished: @escaping Action
    ) {
        let group = DispatchGroup()
        group.enter(count)
        enumerate { index, url in
            DispatchQueue.main.asyncAfter(deadline: .now() + waitTime) {
                url.getData { data in
                    enumerateCall(index, url, data)
                    group.leave()
                }
            }
        }
        group.notify(queue: DispatchQueue.main) {
            finished()
        }
    }
}

extension URL {
    
    /// back represents the number of 10 day units back we are getting the data for.
    /// TD Ameritrade allows 120 calls a minute
    static func saveHistory(
        for tickers: [String],
        back: Int,
        completion: @escaping Action
    ) {
        let tickersFinish = DispatchGroup()
        tickers.forEach { ticker in
            tickersFinish.enter(tickers.count)
            var allCandles = CandleList(symbol: ticker)
            (0...back).forEach { int in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let mins = 10 * 24 * 60
                    let url = URL.priceHistory(
                        period: .days(.ten, .oneMinute),
                        endDate: Date(timeFromNow: int * mins),
                        startDate: Date(timeFromNow: (int + 1) * mins),
                        ticker: ticker
                    )
                    print("--->", url.absoluteString)
                    url.getData { data in
                        tickersFinish.leave()
                        guard let candles = CandleList(data) else { return }
                        allCandles.candles.append(contentsOf: candles.candles)
                    }
                }
            }
            tickersFinish.notify(queue: DispatchQueue.main) {
                allCandles.candles.sort { $0.datetime > $1.datetime }
                guard let dataframe = DataFrame(allCandles) else { return }
                let csv = dataframe.convertToCSV(
                    named: ticker + "_" + Date().timeIntervalSince1970.string
                )
                print(csv?.absoluteString ?? "nil")
                completion()
            }
        }
    }
    
    typealias DataFrameAction = (DataFrame?) -> Void
    
    
    @discardableResult
    static func priceHistories(
        apiKey: String? = Bundle.td_api_key,
        period: Period = .days(.ten, .oneMinute),
        endDate: Date = Date(),
        startDate: Date? = Calendar.current.date(
        byAdding: .year,
        value: -1,
        to: Date()
        ),
        needExtendedHoursData: Bool? = false, // true for swing trades, false for day trades.
        ticker: String,
        dataFrameAction: @escaping DataFrameAction
    ) -> [URL] {
        guard let startDate = startDate else { return [] }
        let urls = [ClosedRange<Date>](
            startDate: startDate,
            enddate: endDate,
            dayCount: period.dateIncrement.value
        ).map {
            URL.priceHistory(
                apiKey: apiKey,
                period: period,
                endDate: $0.upperBound,
                startDate: $0.lowerBound,
                needExtendedHoursData: needExtendedHoursData,
                ticker: ticker
            )
        }
        var candles: [Candle] = []
        let group = DispatchGroup()
        group.enter(urls.count)
        urls.enumerate { index, url in
            url.getData { data in
                if let candleListCandles = CandleList(data)?.candles {
                    candles.append(contentsOf: candleListCandles)
                } else {
                    print("ERROR: Should not reach.")
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            dataFrameAction(
                DataFrame(
                    CandleList(
                        candles: candles.sorted { $0.datetime > $1.datetime },
                        empty: false,
                        symbol: ticker
                    )
                )
            )
        }
        return urls
    }
    
    static func priceHistoryURLS(
        apiKey: String? = Bundle.td_api_key,
        period: Period = .days(.ten, .oneMinute),
        endDate: Date,
        startDate: Date,
        needExtendedHoursData: Bool? = false, // true for swing trades, false for day trades.
        ticker: String,
        dataFrameAction: @escaping DataFrameAction
    ) -> [URL] {
        let urls = [ClosedRange<Date>](
            startDate: startDate,
            enddate: endDate,
            dayCount: period.dateIncrement.value
        ).map {
            URL.priceHistory(
                apiKey: apiKey,
                period: period,
                endDate: $0.upperBound,
                startDate: $0.lowerBound,
                needExtendedHoursData: needExtendedHoursData,
                ticker: ticker
            )
        }
        var candles: [Candle] = []
        let group = DispatchGroup()
        group.enter(urls.count)
        urls.enumerate { index, url in
            url.getData { data in
                if let candleListCandles = CandleList(data)?.candles {
                    candles.append(contentsOf: candleListCandles)
                } else {
                    print("ERROR: Should not reach.")
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            dataFrameAction(
                DataFrame(
                    CandleList(
                        candles: candles.sorted { $0.datetime > $1.datetime },
                        empty: false,
                        symbol: ticker
                    )
                )
            )
        }
        return urls
    }
    
    
    
    /// Header: Authorization: Bearer <access token>
    static func priceHistory(
        apiKey: String? = Bundle.td_api_key,
        period: Period = .days(.ten, .oneMinute),
        endDate: Date? = nil,
        startDate: Date? = nil,
        needExtendedHoursData: Bool? = false, // true for swing trades, false for day trades.
        ticker: String
    ) -> URL {
        TDAmeritradeURL(
            path: .slashes(.marketData, ticker, .priceHistory)
        ).apiKey(apiKey)
            .period(period)
            .endDate(endDate)
            .startDate(startDate)
            .needsExtendedHoursData(needExtendedHoursData)
            .build
    }
    
    
    enum Period {
        case days(DayCount, Minute)
        case months(MonthCount, DailyWeekly)
        case years(YearCount, DailyWeeklyMonthly)
        case ytd(DailyWeekly)
        
        
        var dateIncrement: Date.Increment {
            switch self {
            case .days(let dayCount, _):
                return dayCount.dateIncrement
            case .months(let monthCount, _):
                return monthCount.dateIncrement
            case .years(let yearCount, _):
                return yearCount.dateIncrement
            case .ytd(let yearAssociated):
                return yearAssociated.dateIncrement
            }
        }
        
        var dictionary: [TDAmeritradeURL.Key: String] {
            var dict: [TDAmeritradeURL.Key: String] = [:]
            dict[.periodType] = string
            switch self {
            case .days(let dayCount, let minute):
                dict[.period] = dayCount.rawValue.string
                dict[.frequency] = minute.rawValue
                dict[.frequencyType] = Minute.path
            case .months(let monthCount, let dailyWeekly):
                dict[.period] = monthCount.rawValue.string
                dict[.frequency] = 1.string
                dict[.frequencyType] = dailyWeekly.rawValue
            case .years(let yearCount, let dailyWeeklyMonthly):
                dict[.period] = yearCount.rawValue.string
                dict[.frequency] = 1.string
                dict[.frequencyType] = dailyWeeklyMonthly.rawValue
            case .ytd(let dailyWeekly):
                dict[.period] = 1.string
                dict[.frequency] = 1.string
                dict[.frequencyType] = dailyWeekly.rawValue
            }
            return dict
        }
        
        var string: String {
            switch self {
            case .days(_, _): return "day"
            case .months(_, _): return "month"
            case .years(_, _): return "year"
            case .ytd(_): return "ytd"
            }
        }
        
        enum DailyWeekly: String {
            case daily, weekly
            
            var dateIncrement: Date.Increment {
                // Ignored for year to date
                Date.Increment(component: .year, value: 1)
            }
        }
        
        enum DailyWeeklyMonthly: String {
            case daily, weekly, monthly
        }
        
        enum Minute: String {
            case oneMinute = "1"
            case fiveMinutes = "5"
            case tenMinutes = "10"
            case fifteen = "15"
            case thirty = "30"
            
            static var path: String {
                return "minute"
            }
        }
        
        enum DayCount: Int {
            case one = 1
            case two = 2
            case three = 3
            case four = 4
            case five = 5
            case ten = 10
            
            var dateIncrement: Date.Increment {
                Date.Increment(component: .day, value: rawValue)
            }
            
            init() {
                self = .ten
            }
        }
        
        enum MonthCount: Int {
            case one = 1
            case two = 2
            case three = 3
            case six = 6
            
            var dateIncrement: Date.Increment {
                Date.Increment(component: .month, value: rawValue)
            }
            
            init() {
                self = .one
            }
        }
        
        enum YearCount: Int {
            case one = 1
            case two = 2
            case three = 3
            case five = 5
            case ten = 10
            case fifteen = 15
            case twenty = 20
            
            var dateIncrement: Date.Increment {
                Date.Increment(component: .year, value: rawValue)
            }
            
            init() {
                self = .one
            }
        }
    }
}


extension Date {
    struct Increment {
        var component: Calendar.Component
        var value: Int
    }
}

extension Array where Element == ClosedRange<Date> {
    
    ///Purpose: create date ranges for urls.  The TDAmeritrade API and other apis limit the date ranges for which you can make api calls.  TD Ameritrade provides minute to minute quotes for 10 day ranges.
    /// Strategy: Creates Date ranges where the upperbound is the most recent date of the daycount range.
    /// - StartDate: the most recent date looking back.
    /// - EndDate: The earliest date looking back.
    /// - dayCount: The distance back for which the range goes.
    init(
        startDate: Date = Date(),
        enddate: Date? = Calendar.current.date(
        byAdding: .year,
        value: -1,
        to: Date()
        ),
        dayCount: Int
    ) {
        self = []
        guard var early: Date = enddate?.days(earlier: dayCount) else {
            return
        }
        let late = startDate
        self.append(early...late)
        while early > startDate {
            if let newLate = early.oneSecondEarlier,
                let newEarly = newLate.days(earlier: dayCount) {
                early = newEarly
                self.append(newEarly...newLate)
            } else {
                assert(false, "Should not reach")
                return
            }
        }
    }
}



extension Date {
    func days(earlier dayCount: Int) -> Date? {
        Calendar.current.date(
            byAdding: .day,
            value: dayCount * -1,
            to: self
        )
    }
    
    var oneSecondEarlier: Date? {
        Calendar.current.date(
            byAdding: .second,
            value: -1,
            to: self
        )
    }
}
