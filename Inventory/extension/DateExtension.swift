//
//  DateExtension.swift
//  FMS SPS 2017
//
//  Created by Elluminati iTunesConnect on 18/11/17.
//  Copyright © 2017 Harshil Kotecha. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(withFormat format: String,timeZone:String = "") -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if timeZone != "" {
            formatter.timeZone = TimeZone.init(abbreviation: timeZone)
        }
        let myString = formatter.string(from: self)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = format
        return formatter.string(from: yourDate!)
    }
    func isSameDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedSame
    }
    
    func isBeforeDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedAscending
    }
    
    func isAfterDate(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedDescending
    }
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    func dayNumberOfWeek() -> Int
    {
        return (Calendar.current.dateComponents([.weekday], from: self).weekday ?? 1) - 1
    }
}

