//
//  Expenses.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import Foundation

@Model
class Expenses {
    var amount: Double
    var entryDate: Date
    var expDescription: String
    var subcategory: Subcategories?

    init(amount: Double, entryDate: Date = .now, expDescription: String, subcategory: Subcategories?) {
        self.amount = amount
        self.entryDate = entryDate
        self.expDescription = expDescription
        self.subcategory = subcategory
    }
}
