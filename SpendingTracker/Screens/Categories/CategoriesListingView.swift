//
//  CategoriesListingView.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import SwiftUI

struct CategoriesListingView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var categories: [Categories]
    
    init(sort: SortDescriptor<Categories>, searchString: String) {
        _categories = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    var body: some View {
        List {
            ForEach(categories) { category in
                NavigationLink(value: category) {
                    VStack(alignment: .leading) {
                        Label(category.name, systemImage: category.iconName)
                            .font(.headline)
                    }
                }
            }
            .onDelete(perform: deleteCategory)
        }
    }
    
    func deleteCategory(_ indexSet: IndexSet) {
        for index in indexSet {
            let category = categories[index]
            modelContext.delete(category)
        }
    }
}
