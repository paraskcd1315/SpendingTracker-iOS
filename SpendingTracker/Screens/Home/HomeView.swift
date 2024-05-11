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
                        var bankBalance = settings[0].bankBalance
                        var cashBalance = settings[0].cashBalance
                        var budget = settings[0].budget
                        var numberOfDays = Date().numberOfDaysBetweenCurrentAndEnd()
                        var total = (bankBalance + cashBalance) - budget
                        var dailyLimit = total / numberOfDays
                        var spentToday = 0.00
                        var earntToday = 0.00
                        
                        
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
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem {
                    Button("Add Journal", systemImage: "plus", action: addJournal)
                }
            }
        }
    }
    
    func addJournal() {
        
    }
}
