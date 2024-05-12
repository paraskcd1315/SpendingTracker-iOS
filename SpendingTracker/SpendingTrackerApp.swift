//
//  SpendingTrackerApp.swift
//  SpendingTracker
//
//  Created by Paras KCD on 11/5/24.
//

import SwiftData
import SwiftUI

@main
struct SpendingTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: MainSettings.self)
    }
}
