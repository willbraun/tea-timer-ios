//
//  TeaDetailView.swift
//  TeaTimer
//
//  Created by Will Braun on 12/16/25.
//

import SwiftUI

struct TeaDetailView: View {
    let teaItem: TeaItem
    
    var totalTime: Int {
        teaItem.steepTimeMin + teaItem.restTimeMin
    }
    
    var body: some View {
        Text("Tea Name: \(teaItem.name)")

        Text("Amount: \(teaItem.amountTsp) tsp")
        Text("Water Temp: \(teaItem.temperatureF)°F")

        Text("Steep: \(teaItem.steepTimeMin) min")
        Text("Rest: \(teaItem.restTimeMin) min")
        Text("Total: \(totalTime) min")
    }
}

#Preview {
    let sampleTea: TeaItem = TeaItem(name: "Oolong")
    TeaDetailView(teaItem: sampleTea)
}
