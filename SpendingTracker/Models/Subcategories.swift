//
//  Subcategories.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import Foundation

@Model
class Subcategories {
    var name: String
    var category: Categories?
    
    @Relationship(deleteRule: .cascade) var income: [Income] = [Income]()
    @Relationship(deleteRule: .cascade) var expenses: [Expenses] = [Expenses]()
    
    init(name: String, category: Categories?) {
        self.name = name
        self.category = category
    }
}
