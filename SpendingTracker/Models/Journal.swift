//
//  Journal.swift
//  SpendingTracker
//
//  Created by Paras KCD on 12/5/24.
//

import Foundation

class Journal: Identifiable {
    var amount: Double
    var desc: String
    var entryDate: Date
    var isExpense: Bool
    var isCash: Bool
    var expense: Expenses?
    var income: Income?
    
    init(amount: Double, desc: String, entryDate: Date, isExpense: Bool, isCash: Bool, expense: Expenses?, income: Income?) {
        self.amount = amount
        self.desc = desc
        self.entryDate = entryDate
        self.isExpense = isExpense
        self.isCash = isCash
        self.expense = expense
        self.income = income
    }
}
