//
//  Categories.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import Foundation

@Model
class Categories {
    var name: String
    var iconName: String
    var setting: MainSettings?
    @Relationship(deleteRule: .cascade) var subcategories: [Subcategories] = [Subcategories]()
    
    init(name: String = "", iconName: String = "", setting: MainSettings? = nil, subcategories: [Subcategories] = []) {
        self.name = name
        self.iconName = iconName
        self.setting = setting
        self.subcategories = subcategories
    }
}
