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
    @StateObject private var timerStore = TeaTimerStore()
    
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: TeaItem.self)

            let context = container.mainContext
            let descriptor = FetchDescriptor<TeaItem>()

            let existing = try context.fetch(descriptor)
            if existing.isEmpty {
                context.insert(TeaItem(name: "White", temperatureF: 180, steepTimeMin: 3, restTimeMin: 3))
                context.insert(TeaItem(name: "Green", temperatureF: 180, steepTimeMin: 2, restTimeMin: 3))
                context.insert(TeaItem(name: "Black", temperatureF: 212, steepTimeMin: 5, restTimeMin: 4))
            }
        } catch {
            fatalError("SwiftData setup failed: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(timerStore)
        }
        .modelContainer(container)
    }
}
