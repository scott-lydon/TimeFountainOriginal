//
//  Date.swift
//  ScottLydon
//
//  Created by Scott Lydon on 10/2/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import Foundation

public extension Date {
    
    typealias Minutes = Int
    
    init?(timeFromNow: Minutes) {
        guard let date = Calendar.current.date(
            byAdding: .minute,
            value: timeFromNow,
            to: Date()
            ) else { return nil}
        self = date
    }
    
    var clockTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.locale = .current
        return dateFormatter.string(from: self)
    }
    
    var minutesSinceNow: Int {
        Int(timeIntervalSinceNow / 60.0)
    }
    
    var secondsSinceNow: Double {
        timeIntervalSinceNow
    }
    
    var isOlderThan18: Bool {
        self.secondsSinceNow > 18.yearsInSeconds
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    var apiString: String {
        let df = DateFormatter()
        df.dateFormat = .commonDateFormat
        df.timeZone = TimeZone(identifier: "GMT")
        return df.string(from: self)
    }
    

    enum DayOfWeek: String {
        case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    }

}
