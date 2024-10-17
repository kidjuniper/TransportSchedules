//
//  DateOptions.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

enum DateOption {
    case today
    case tomorrow
    case customDate(Date)
    
    var date: Date {
        let calendar = Calendar.current
        switch self {
        case .today:
            return calendar.startOfDay(for: Date())
        case .tomorrow:
            return calendar.date(byAdding: .day,
                                 value: 1,
                                 to: calendar.startOfDay(for: Date())) ?? Date()
        case .customDate(let date):
            return date
        }
    }
    
    var localizedDate: Date {
        let timeZoneOffset = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
        return date.addingTimeInterval(timeZoneOffset)
    }
}
