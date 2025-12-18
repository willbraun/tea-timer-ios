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
        ZStack {
            switch timer.phase {
            case .idle:
                Button(action: {
                    timer.startSteep(seconds: teaItem.steepTimeMin)
                }) {
                    Text("Steep")
                        .font(.headline)
                        .frame(width: 200, height: 48)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

            case .steeping:
                Text("Steeping: \(timeString(timer.remaining))")
                    .font(.headline)
                    .frame(width: 200, height: 48)
                    .background(.yellow)
                    .cornerRadius(12)
            
            case .resting:
                Text("Resting: \(timeString(timer.remaining))")
                    .font(.headline)
                    .frame(width: 200, height: 48)
                    .background(.purple.opacity(0.5))
                    .cornerRadius(12)

            case .ready:
                Text("Ready")
                    .frame(width: 200, height: 48)
                    .font(.headline)
                    .background(.green)
                    .cornerRadius(12)
            }
        }
        .animation(.spring(), value: timer.phase)
        .onChange(of: timer.phase) {
            if timer.phase == .resting {
                timer.startRest(seconds: teaItem.restTimeMin)
            }
         }
    }

    private func timeString(_ seconds: Int) -> String {
        "\(seconds / 60):\(String(format: "%02d", seconds % 60))"
    }
}

#Preview {
    SteepButton(teaItem: TeaItem(name: "White")).environmentObject(TeaTimerStore())
}
