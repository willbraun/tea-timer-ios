//
//  ContentView.swift
//  TeaTimer
//
//  Created by Will Braun on 12/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: \TeaItem.name, order: .forward) private var teaItems: [TeaItem]

    var body: some View {
        NavigationView {
            VStack {
//                Text("Tap on this button to add tea")
//                Button("Add Tea") {
//                    addItem()
//                }
                List {
                    ForEach (teaItems) { item in
                        NavigationLink(destination: TeaDetailView(teaItem: item)) {
                            Text(item.name)
                        }
                    }
                    .onDelete { indicies in
                        for index in indicies {
                            deleteItem(teaItems[index])
                        }
                        
                    }
                }
            }
        }
    }
    
    func addItem() {
        let item = TeaItem(name: "Test Name")
        context.insert(item)
    }
    
    func deleteItem(_ item: TeaItem) {
        context.delete(item)
    }
}

#Preview {
    let container = try! ModelContainer(
        for: TeaItem.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext
    context.insert(TeaItem(name: "White", temperatureF: 180, steepTimeMin: 3, restTimeMin: 3))
    context.insert(TeaItem(name: "Green", temperatureF: 180, steepTimeMin: 2, restTimeMin: 3))
    context.insert(TeaItem(name: "Black", temperatureF: 212, steepTimeMin: 5, restTimeMin: 4))

    return ContentView()
        .modelContainer(container).environmentObject(TeaTimerStore())
}
