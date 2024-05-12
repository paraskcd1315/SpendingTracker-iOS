//
//  Date.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date {
        return Calendar.current.date(byAdding: DateComponents(day: 1), to: self.startOfDay())!
    }
    
    func numberOfDaysBetweenCurrentAndEnd() -> Double {
        let calendar = Calendar.current
        let fromDate = Date.now // <1>
        let toDate = Date().endOfMonth() // <2>
        let numberOfDays = calendar.dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return Double(numberOfDays.day!)
    }
}
