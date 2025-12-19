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
        VStack(alignment: .leading, spacing: 8) {
            Text(teaItem.name)
                .font(.title)
            
            HStack {
                Text("Amount:")
                Spacer()
                Text("\(teaItem.amountTsp) tsp")
            }
            
            HStack {
                Text("Water Temp:")
                Spacer()
                Text("\(teaItem.temperatureF)°F")
            }
            
            HStack {
                Text("Steep:")
                Spacer()
                Text("\(teaItem.steepTimeMin) min")
            }
            
            HStack {
                Text("Rest:")
                Spacer()
                Text("\(teaItem.restTimeMin) min")
            }
            
            HStack {
                Text("Total:")
                Spacer()
                Text("\(totalTime) min")
            }
            
            Spacer()
            
            HStack {
                Spacer()
                SteepButton(teaItem: teaItem)
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .cornerRadius(8)
    }
}

#Preview {
    let sampleTea: TeaItem = TeaItem(name: "White")
    TeaDetailView(teaItem: sampleTea).environmentObject(TeaTimerStore())
}
