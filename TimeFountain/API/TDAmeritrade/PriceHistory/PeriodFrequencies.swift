//
//  PeriodFrequencies.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    
    /// Header: Authorization: Bearer <access token>
    static func priceHistory(
        apiKey: String? = Bundle.td_api_key,
        period: Period,
        endDate: Date? = nil,
        startDate: Date? = nil,
        needExtendedHoursData: Bool? = nil,
        ticker: String
    ) -> URL {
        return TDAmeritradeURL(path: .slashes(.marketData, ticker, .priceHistory))
            .apiKey(apiKey)
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
            
            init() {
                self = .ten
            }
        }
        
        enum MonthCount: Int {
            case one = 1
            case two = 2
            case three = 3
            case six = 6
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
            init() {
                self = .one
            }
        }
    }
}
