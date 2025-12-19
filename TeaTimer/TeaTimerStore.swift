//
//  TeaTimerStore.swift
//  TeaTimer
//
//  Created by Will Braun on 12/18/25.
//

import SwiftUI
import Combine

final class TeaTimerStore: ObservableObject {
    @Published var phase: Phase = .idle
    @Published var remaining: Int = 0
    @Published var activeTea: TeaItem?

    enum Phase {
        case idle
        case steeping
        case resting
        case ready
    }
    
    var label: String {
        switch self.phase {
        case .idle: return "Steep"
        case .steeping: return "Steeping"
        case .resting: return "Resting"
        case .ready: return "Ready"
        }
    }
    
    var color: Color {
        switch self.phase {
        case .idle: return .gray
        case .steeping: return .yellow
        case .resting: return .purple
        case .ready: return .green
        }
    }
    
    var isActive: Bool {
        self.phase == .steeping || self.phase == .resting
    }

    private var cancellable: AnyCancellable?

    func startSteep(teaItem: TeaItem) {
        activeTea = teaItem
        phase = .steeping
        remaining = teaItem.steepTimeMin
        startTimer()
    }

    func startRest(teaItem: TeaItem) {
        guard let teaItem = activeTea else { return }
        phase = .resting
        remaining = teaItem.restTimeMin
        startTimer()
    }

    func stop() {
        cancellable?.cancel()
        phase = .idle
    }

    private func startTimer() {
        cancellable?.cancel()

        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                remaining -= 1

                if remaining <= 0 {
                    cancellable?.cancel()
                    phase = phase == .steeping ? .resting : .ready
                }
            }
    }
}
