//
//  Setting.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import Foundation

@Model
class MainSettings {
    var bankBalance: Double
    var cashBalance: Double
    var budget: Double
    var updatedDate: Date
    var categories: [Categories] = [Categories]()
    
    init(bankBalance: Double = Double(0.00), cashBalance: Double = Double(0.00), budget: Double = Double(0.00), updatedDate: Date = .now) {
        self.bankBalance = bankBalance
        self.cashBalance = cashBalance
        self.budget = budget
        self.updatedDate = updatedDate
    }
}
