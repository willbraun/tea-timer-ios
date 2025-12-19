//
//  SteepButton.swift
//  TeaTimer
//
//  Created by Will Braun on 12/18/25.
//

import SwiftUI

struct SteepButton: View {
    @EnvironmentObject var timer: TeaTimerStore
    
    let teaItem: TeaItem

    var body: some View {
        Button {
            timer.startSteep(teaItem: teaItem)
        } label: {
            Text(timer.isActive
                 ? "\(timer.label) \(timer.activeTea?.id == teaItem.id ? "" : timer.activeTea?.name ?? "")"
                 : "Steep")
        }
        .font(.headline)
        .frame(width: 200, height: 48)
        .background(timer.isActive ? timer.color : .blue)
        .foregroundColor(timer.isActive ? .black : .white)
        .cornerRadius(12)
        .disabled(timer.isActive)
        .opacity(timer.isActive ? 0.5 : 1)
        .animation(.spring(), value: timer.phase)
        .onChange(of: timer.phase) {
            if timer.phase == .resting {
                timer.startRest(teaItem: teaItem)
            }
         }
    }
}

#Preview {
    SteepButton(teaItem: TeaItem(name: "White")).environmentObject(TeaTimerStore())
}
