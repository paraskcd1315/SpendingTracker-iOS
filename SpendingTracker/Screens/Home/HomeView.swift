//
//  HomeView.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var settings: [MainSettings]
    @Query var expenses: [Expenses]
    @Query var income: [Income]
    @Query(sort: [SortDescriptor(\Subcategories.name)]) var subcategories: [Subcategories]
    @State private var showingSheet = false
    
    let locale = Locale.current
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if (settings.isEmpty) {
                        Button("Tap Here for Initial Setup") {
                            let mainSetting = MainSettings()
                            modelContext.insert(mainSetting)
                        }
                    } else {
                        let bankBalance = settings[0].bankBalance
                        let cashBalance = settings[0].cashBalance
                        let budget = settings[0].budget
                        let numberOfDays = Date().numberOfDaysBetweenCurrentAndEnd()
                        let total = (bankBalance + cashBalance) - budget
                        let dailyLimit = total / numberOfDays
                        let spentToday = totalSpent()
                        let earntToday = totalEarnt()
                        
                        VStack {
                            Text("Daily Expense Limit")
                            Text(dailyLimit.formatted(.currency(code: locale.currency!.identifier)))
                                .font(.system(size: 40, weight: .black))
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Spacer()
                            .frame(height: 12)
                        
                        VStack {
                            Text("Spent Today")
                            Text(spentToday.formatted(.currency(code: locale.currency!.identifier)))
                                .font(.system(size: 40, weight: .black))
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Spacer()
                            .frame(height: 12)
                        
                        VStack {
                            Text("Earnt Today")
                            Text(earntToday.formatted(.currency(code: locale.currency!.identifier)))
                                .font(.system(size: 40, weight: .black))
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Spacer()
                            .frame(height: 12)
                        
                        VStack {
                            Text("Cash")
                            Text(cashBalance.formatted(.currency(code: locale.currency!.identifier)))
                                .font(.system(size: 40, weight: .black))
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Spacer()
                            .frame(height: 12)
                        
                        VStack {
                            Text("Bank")
                            Text(bankBalance.formatted(.currency(code: locale.currency!.identifier)))
                                .font(.system(size: 40, weight: .black))
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Spacer()
                            .frame(height: 12)
                        
                        VStack {
                            Text("Budget")
                            Text(budget.formatted(.currency(code: locale.currency!.identifier)))
                                .font(.system(size: 40, weight: .black))
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $showingSheet) {
                AddJournalView(subcategory: subcategories[0], dismiss: { showingSheet.toggle() })
            }
            .navigationTitle("Home")
            .toolbar {
                if !(subcategories.isEmpty) {
                    ToolbarItem {
                        Button("Add Journal", systemImage: "plus", action: addJournal)
                    }
                }
            }
        }
    }
    
    func addJournal() {
        showingSheet.toggle()
    }
    
    func totalSpent() -> Double {
        var addedAmount = 0.00
        let startDate = Date().startOfDay()
        let endDate = Date().endOfDay()
        if !expenses.isEmpty {
            for expense in expenses {
                if startDate <= expense.entryDate && endDate >= expense.entryDate {
                    addedAmount += expense.amount
                }
            }
        }
        
        return addedAmount
    }
    
    func totalEarnt() -> Double {
        var addedAmount = 0.00
        let startDate = Date().startOfDay()
        let endDate = Date().endOfDay()
        if !income.isEmpty {
            for inc in income {
                if startDate <= inc.entryDate && endDate >= inc.entryDate {
                    addedAmount += inc.amount
                }
            }
        }
        
        return addedAmount
    }
}
