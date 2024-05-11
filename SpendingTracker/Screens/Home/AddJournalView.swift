//
//  AddJournalView.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import SwiftUI

struct AddJournalView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var settings: [MainSettings]
    @Query(sort: [SortDescriptor(\Subcategories.name)]) var subcategories: [Subcategories]
    @State private var selectedTab: Int = 0
    @State private var amount: Double = 0.00
    @State private var description: String = ""
    @State var subcategory: Subcategories
    @State private var isCash: Bool = false
    
    var dismiss: () -> Void
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Expense").tag(0)
                Text("Income").tag(1)
            }
            .padding([.horizontal, .top])
            .pickerStyle(SegmentedPickerStyle())
            Form {
                switch (selectedTab) {
                    case 0:
                    Section("Expense Details") {
                        HStack {
                            Text("Amount: ")
                                .frame(width: 100, alignment: .leading)
                            TextField("Amount", value: $amount, format: .currency(code: "EUR"))
                        }
                        HStack {
                            Text("Description:")
                                .frame(width: 100, alignment: .leading)
                            TextEditor(text: $description)
                        }
                        Picker("Subcategory:", selection: $subcategory) {
                            ForEach(subcategories) { subcategory in
                                Label(subcategory.name, systemImage: subcategory.category?.iconName ?? "house")
                                    .tag(subcategory)
                            }
                        }
                        Toggle("Cash Expense", isOn: $isCash)
                    }
                    default:
                    Section("Income Details") {
                        HStack {
                            Text("Amount: ")
                                .frame(width: 100, alignment: .leading)
                            TextField("Amount", value: $amount, format: .currency(code: "EUR"))
                        }
                        HStack {
                            Text("Description:")
                                .frame(width: 100, alignment: .leading)
                            TextEditor(text: $description)
                        }
                        Picker("Subcategory:", selection: $subcategory) {
                            ForEach(subcategories) { subcategory in
                                Label(subcategory.name, systemImage: subcategory.category?.iconName ?? "house")
                                    .tag(subcategory)
                            }
                        }
                        Toggle("Cash Income", isOn: $isCash)
                    }
                }
                Section {
                    Button("Save") {
                        if (selectedTab == 0) {
                            addExpense()
                        } else {
                            addIncome()
                        }
                        dismiss()
                    }
                }
            }
        }
    }
    
    func addExpense() {
        let expense = Expenses(amount: amount, expDescription: description, isCash: isCash, subcategory: nil)
        subcategory.expenses.append(expense)
        settings[0].updatedDate = expense.entryDate
        settings[0].bankBalance = isCash ? settings[0].bankBalance : settings[0].bankBalance - amount
        settings[0].cashBalance = isCash ? settings[0].cashBalance - amount : settings[0].cashBalance
    }
    
    func addIncome() {
        let income = Income(amount: amount, incDescription: description, isCash: isCash, subcategory: nil)
        subcategory.income.append(income)
        settings[0].updatedDate = income.entryDate
        settings[0].bankBalance = isCash ? settings[0].bankBalance : settings[0].bankBalance + amount
        settings[0].cashBalance = isCash ? settings[0].cashBalance + amount : settings[0].cashBalance
    }
}
