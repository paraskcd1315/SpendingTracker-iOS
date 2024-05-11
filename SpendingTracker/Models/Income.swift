//
//  Income.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import Foundation

@Model
class Income {
    var amount: Double
    var entryDate: Date
    var incDescription: String
    var subcategory: Subcategories?
    
    init(amount: Double, entryDate: Date = .now, incDescription: String, subcategory: Subcategories?) {
        self.amount = amount
        self.entryDate = entryDate
        self.incDescription = incDescription
        self.subcategory = subcategory
    }
}
