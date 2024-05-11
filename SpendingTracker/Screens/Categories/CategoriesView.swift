//
//  CategoriesView.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import SwiftUI

struct CategoriesView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var mainSettings: [MainSettings]
    @State private var path = [Categories]()
    @State private var sortOrder = SortDescriptor(\Categories.name)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            CategoriesListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("Categories")
                .navigationDestination(for: Categories.self) { category in
                    EditCategoryView(category: category)
                }
                .toolbar {
                    Button("Add Category", systemImage: "plus", action: addCategory)
                }
                .searchable(text: $searchText)
                
        }
    }
    
    func addCategory() {
        if (mainSettings.isEmpty) {
            let category = Categories()
            let mainSetting = MainSettings()
            mainSetting.categories.append(category)
            modelContext.insert(mainSetting)
            path = [category]
        } else {
            let category = Categories()
            mainSettings[0].categories.append(category)
            modelContext.insert(category)
            path = [category]
        }
    }
}

#Preview {
    CategoriesView()
}
