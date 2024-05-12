//
//  DateFormatter.swift
//  SpendingTracker
//
//  Created by Paras KCD on 12/5/24.
//

import Foundation

extension DateFormatter {
    static let showMonth: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "MMMM"
         return formatter
    }()
    
    static let showCustomDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM YYYY, hh:mm a"
        return formatter
    }()
}
