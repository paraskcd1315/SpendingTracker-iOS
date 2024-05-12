//
//  JournalView.swift
//  SpendingTracker
//
//  Created by Paras KCD on 12/5/24.
//

import SwiftData
import SwiftUI

struct JournalView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var settings: [MainSettings]
    @Query var incomes: [Income]
    @Query var expenses: [Expenses]
    let locale = Locale.current
    
    @State private var showAlert: Bool = false
    @State private var selectedJournal: Journal?
    
    var body: some View {
        let journal = journalArray()
        
        NavigationStack {
            ScrollView {
                ForEach(journal) { entry in
                    Button {
                        selectedJournal = entry
                        showAlert.toggle()
                    } label: {
                        VStack {
                            HStack {
                                Text("\(DateFormatter.showCustomDateTime.string(from: entry.entryDate))")
                                Spacer()
                                if entry.isExpense {
                                    Text("Expense")
                                } else {
                                    Text("Income")
                                }
                            }
                            Spacer()
                                .frame(height: 12)
                            Text(entry.amount.formatted(.currency(code: locale.currency!.identifier)))
                                .font(.system(size: 40, weight: .black))
                            Spacer()
                                .frame(height: 12)
                            Text(entry.desc)
                        }
                        
                    }
                    .tint(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)
            }
            .navigationTitle("Journal")
            .alert(isPresented: $showAlert) {
                if (selectedJournal != nil) {
                    if (selectedJournal!.isExpense == true) {
                        Alert(
                            title: Text("Delete Expense"),
                            message: Text("Are you sure you want to delete this Expense of \(selectedJournal!.amount.formatted(.currency(code: locale.currency!.identifier)))."),
                            primaryButton: .default(
                                Text("Cancel"),
                                action: { showAlert.toggle() }
                            ),
                            secondaryButton: .destructive(
                                Text("Delete"),
                                action: {
                                    if (selectedJournal != nil) {
                                        if (selectedJournal!.expense != nil) {
                                            let expense = selectedJournal!.expense
                                            modelContext.delete(expense!)
                                            settings[0].updatedDate = .now
                                            settings[0].bankBalance = selectedJournal!.isCash ? settings[0].bankBalance : settings[0].bankBalance + selectedJournal!.amount
                                            settings[0].cashBalance = selectedJournal!.isCash ? settings[0].cashBalance + selectedJournal!.amount : settings[0].cashBalance
                                        }
                                    }
                                    showAlert.toggle()
                                    selectedJournal = nil
                                }
                            )
                        )
                    } else {
                        Alert(
                            title: Text("Delete Income"),
                            message: Text("Are you sure you want to delete this Expense of \(selectedJournal!.amount.formatted(.currency(code: locale.currency!.identifier)))."),
                            primaryButton: .default(
                                Text("Cancel"),
                                action: {
                                    showAlert.toggle()
                                    selectedJournal = nil
                                }
                            ),
                            secondaryButton: .destructive(
                                Text("Delete"),
                                action: { 
                                    if (selectedJournal != nil) {
                                        if (selectedJournal!.income != nil) {
                                            let income = selectedJournal!.income
                                            modelContext.delete(income!)
                                            settings[0].updatedDate = .now
                                            settings[0].bankBalance = selectedJournal!.isCash ? settings[0].bankBalance : settings[0].bankBalance - selectedJournal!.amount
                                            settings[0].cashBalance = selectedJournal!.isCash ? settings[0].cashBalance - selectedJournal!.amount : settings[0].cashBalance
                                        }
                                    }
                                    showAlert.toggle()
                                    selectedJournal = nil
                                }
                            )
                        )
                    }
                } else {
                    Alert(
                        title: Text("Something went wrong"),
                        message: Text("Can't delete journal.")
                    )
                }
            }
        }
        
    }
    
    func journalArray() -> [Journal] {
        var journalArray: [Journal] = []
        for income in incomes {
            let journal = Journal(amount: income.amount, desc: income.incDescription, entryDate: income.entryDate, isExpense: false, isCash: income.isCash, expense: nil, income: income)
            journalArray.append(journal)
        }
        for expense in expenses {
            let journal = Journal(amount: expense.amount, desc: expense.expDescription, entryDate: expense.entryDate, isExpense: true, isCash: expense.isCash, expense: expense, income: nil)
            journalArray.append(journal)
        }
        return journalArray.sorted { $0.entryDate > $1.entryDate }
    }
}
