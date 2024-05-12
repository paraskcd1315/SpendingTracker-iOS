//
//  EditSubcategoryView.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftUI

struct EditSubcategoryView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var subcategory: Subcategories
    @State private var selectedTab: Int = 0
    
    let locale = Locale.current
    
    var body: some View {
        Form {
            Section("Subcategory Details") {
                HStack {
                    Text("Name: ")
                    TextField("Name", text: $subcategory.name)
                }
            }
            Section("Journal") {
                Picker("", selection: $selectedTab) {
                    Text("Expenses", comment: "Plural").tag(0)
                    Text("Incomes", comment: "Plural").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                switch(selectedTab) {
                    case 0:
                        VStack(alignment: .leading) {
                            Text("Total Spent in \(DateFormatter.showMonth.string(from: Date.now).capitalizingFirstLetter()): ")
                                .font(.system(size: 12))
                            Text(totalSpentMonth().formatted(.currency(code: locale.currency!.identifier)))
                                .font(.system(size: 24, weight: .bold))
                        }
                        ForEach(
                            subcategory.expenses
                                .filter({
                                    let startDate = Date().startOfMonth()
                                    let endDate = Date().endOfMonth()
                                    
                                    return startDate <= $0.entryDate && endDate >= $0.entryDate
                                })
                        ) { expense in
                                VStack(alignment: .leading) {
                                    Text(expense.amount.formatted(.currency(code: locale.currency!.identifier)))
                                        .font(.system(size: 24, weight: .bold))
                                    Text("\(DateFormatter.showCustomDateTime.string(from: expense.entryDate))")
                                        .font(.system(size: 12))
                                }
                            }
                    default:
                        VStack(alignment: .leading) {
                            Text("Total earnt in \(DateFormatter.showMonth.string(from: Date.now).capitalizingFirstLetter()): ")
                                .font(.system(size: 12))
                            Text(totalEarntMonth().formatted(.currency(code: locale.currency!.identifier)))
                                .font(.system(size: 24, weight: .bold))
                        }
                        ForEach(
                            subcategory.income
                                .filter({ inc in
                                    let startDate = Date().startOfMonth()
                                    let endDate = Date().endOfMonth()
                                    
                                    return startDate <= inc.entryDate && endDate >= inc.entryDate
                                })
                        ) { income in
                                VStack(alignment: .leading) {
                                    Text(income.amount.formatted(.currency(code: locale.currency!.identifier)))
                                        .font(.system(size: 24, weight: .bold))
                                    Text("\(DateFormatter.showCustomDateTime.string(from: income.entryDate))")
                                        .font(.system(size: 12))
                                }
                            }
                }
            }
        }
        .navigationTitle(subcategory.name)
    }
    
    func totalSpentMonth() -> Double {
        let expenses = subcategory.expenses
        var addedAmount = 0.00
        let startDate = Date().startOfMonth()
        let endDate = Date().endOfMonth()
        
        for expense in expenses {
            if startDate <= expense.entryDate && endDate >= expense.entryDate {
                addedAmount += expense.amount
            }
        }
        return addedAmount
    }
    
    func totalEarntMonth() -> Double {
        let income = subcategory.income
        var addedAmount = 0.00
        let startDate = Date().startOfMonth()
        let endDate = Date().endOfMonth()
        
        for inc in income {
            if startDate <= inc.entryDate && endDate >= inc.entryDate {
                addedAmount += inc.amount
            }
        }
        return addedAmount
    }
}
