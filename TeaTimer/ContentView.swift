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
    
    @Query private var teaItems: [TeaItem]

    var body: some View {
        
        NavigationView {
            VStack {
                Text("Tap on this button to add tea")
                Button("Add Tea") {
                    addItem()
                }
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
    ContentView()
        .modelContainer(for: TeaItem.self, inMemory: true)
}
