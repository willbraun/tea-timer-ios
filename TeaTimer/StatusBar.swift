//
//  StatusBar.swift
//  TeaTimer
//
//  Created by Will Braun on 12/19/25.
//

import SwiftUI

struct StatusBar: View {
    @EnvironmentObject var timer: TeaTimerStore

    var body: some View {
        HStack {
            Text("\(timer.label) \(timer.activeTea?.name ?? "")")
            Spacer()
            Text("\(timeString(timer.remaining))")
        }
        .font(.headline)
        .padding()
        .frame(height: 80)
        .background(timer.color.ignoresSafeArea(.container, edges: .bottom))
        .animation(.spring(), value: timer.phase)
        
    }
    
    private func timeString(_ seconds: Int) -> String {
        "\(seconds / 60):\(String(format: "%02d", seconds % 60))"
    }
}

#Preview {
    StatusBar().environmentObject(TeaTimerStore())
}
