//
//  ContentView.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var settings: [MainSettings]
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "list.bullet.clipboard")
                }
            
            Group {
                if !(settings.isEmpty) {
                    SettingsView(setting: settings[0])
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                } else {
                    EmptyView()
                }
            }
        }
    }
}
