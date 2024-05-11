//
//  SettingsView.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    @Bindable var setting: MainSettings
    
    enum Field {
        case bankBalance
        case cashBalance
        case budget
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Bank Information") {
                    Text("Enter below the balance of your banks.")
                    HStack {
                        Text("Bank Balance: ")
                            .frame(width: 128, alignment: .leading)
                        TextField("Amount", value: $setting.bankBalance, format: .currency(code: "EUR"))
                            .focused($focusedField, equals: .bankBalance)
                            .onChange(of: setting.bankBalance) { oldValue, newValue in
                                setting.updatedDate = .now
                            }
                    }
                    
                }
                Section("Cash Information") {
                    Text("Enter below the balance of your cash.")
                    HStack {
                        Text("Cash Balance: ")
                            .frame(width: 128, alignment: .leading)
                        TextField("Amount", value: $setting.cashBalance, format: .currency(code: "EUR"))
                            .focused($focusedField, equals: .cashBalance)
                            .onChange(of: setting.cashBalance) { oldValue, newValue in
                                setting.updatedDate = .now
                            }
                    }
                }
                Section("Budget Information") {
                    Text("Enter below the budget to save money.")
                    HStack {
                        Text("Budget: ")
                            .frame(width: 128, alignment: .leading)
                        TextField("Amount", value: $setting.budget, format: .currency(code: "EUR"))
                            .focused($focusedField, equals: .budget)
                            .onChange(of: setting.budget) { oldValue, newValue in
                                setting.updatedDate = .now
                            }
                    }
                }
                Section {
                    Text("Updated on \(setting.updatedDate, formatter: dateFormatter)")
                }
            }
            .onSubmit {
                if (focusedField != nil) {
                    focusedField = nil
                }
            }
            .navigationTitle("Settings")
        }
    }
}
