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
    
    var body: some View {
        Form {
            Section("Subcategory Details") {
                HStack {
                    Text("Name: ")
                    TextField("Name", text: $subcategory.name)
                }
            }
        }
        .navigationTitle(subcategory.name)
    }
}
