//
//  TeaTimerApp.swift
//  TeaTimer
//
//  Created by Will Braun on 12/8/25.
//

import SwiftUI
import SwiftData

// @main is the app entry point
@main
struct TeaTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TeaItem.self)
    }
}
