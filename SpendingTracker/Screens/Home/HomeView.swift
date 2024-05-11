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
    @Query(sort: [SortDescriptor(\Subcategories.name)]) var subcategories: [Subcategories]
    @State private var showingSheet = false
    
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
                        let spentToday = 0.00
                        let earntToday = 0.00
                        
                        VStack {
                            Text("Daily Expense Limit")
                            Text(dailyLimit.formatted(.currency(code: "EUR")))
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
                            Text(spentToday.formatted(.currency(code: "EUR")))
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
                            Text(earntToday.formatted(.currency(code: "EUR")))
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
                            Text(cashBalance.formatted(.currency(code: "EUR")))
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
                            Text(bankBalance.formatted(.currency(code: "EUR")))
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
                            Text(budget.formatted(.currency(code: "EUR")))
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
                ToolbarItem {
                    Button("Add Journal", systemImage: "plus", action: addJournal)
                }
            }
        }
    }
    
    func addJournal() {
        showingSheet.toggle()
    }
}
