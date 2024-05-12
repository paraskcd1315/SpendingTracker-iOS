//
//  EditCategoryView.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftUI

struct EditCategoryView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var category: Categories
    @State private var searchText = ""
    @State private var newSubcategoryName = ""
    @State private var systemImages = ["info.circle.fill", "house.circle.fill", "message.fill", "text.bubble.fill", "phone.circle.fill", "sun.min.fill", "moon.circle.fill", "pencil.circle.fill", "trash.circle.fill", "folder.circle.fill", "archivebox.circle.fill", "bag.circle.fill", "cart.circle.fill", "creditcard.circle.fill", "eurosign.arrow.circlepath", "eurosign.circle.fill", "heart.circle.fill", "cross.case.circle.fill", "eye.circle.fill", "play.circle.fill", "cup.and.saucer.fill", "birthday.cake.fill", "fork.knife.circle.fill"]
    
    var body: some View {
        Form {
            Section("Category Details") {
                HStack {
                    Text("Name: ")
                    TextField("Name", text: $category.name)
                }
                
                Picker("Icon: ", selection: $category.iconName) {
                    ForEach(systemImages, id: \.self) { systemImage in
                        Label(systemImage.capitalizingFirstLetter().split(separator: ".")[0], systemImage: systemImage)
                            .tag(systemImage)
                    }
                }
            }
            
            Section("Subcategories") {
                ForEach(category.subcategories.filter({
                    if searchText.isEmpty {
                        return true
                    } else {
                        return $0.name.localizedStandardContains(searchText)
                    }
                }).sorted {
                    $1.name > $0.name
                }) { subcategory in
                    NavigationLink {
                        EditSubcategoryView(subcategory: subcategory)
                    } label: {
                        Text(subcategory.name)
                    }
                }
                .onDelete(perform: deleteSubcategory)

                HStack {
                    TextField("Add a new subcategory in \(category.name)", text: $newSubcategoryName)
                    Button("Add", action: addSubcategory)
                }
            }
        }
        .navigationTitle(category.name)
        .searchable(text: $searchText, prompt: "Search subcategories")
    }
    
    func addSubcategory() {
        guard newSubcategoryName.isEmpty == false else { return }

        withAnimation {
            let subcategory = Subcategories(name: newSubcategoryName, category: nil)
            category.subcategories.append(subcategory)
            newSubcategoryName = ""
        }
    }
    
    func deleteSubcategory(_ indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                let subcategory = category.subcategories[index]
                modelContext.delete(subcategory)
            }
        }
    }
}
