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

    enum Phase {
        case idle
        case steeping
        case resting
        case ready
    }

    private var cancellable: AnyCancellable?

    func startSteep(seconds: Int) {
        phase = .steeping
        remaining = seconds
        startTimer()
    }

    func startRest(seconds: Int) {
        phase = .resting
        remaining = seconds
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
