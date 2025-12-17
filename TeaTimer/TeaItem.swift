//
//  Item.swift
//  TeaTimer
//
//  Created by Will Braun on 12/8/25.
//

import Foundation
import SwiftData

// @Model lets SwiftData use this class as a data model
@Model
final class TeaItem: Identifiable {
    var id: String
    var name: String
    var amountTsp: Int
    var temperatureF: Int
    var steepTimeMin: Int
    var restTimeMin: Int
    
    init(name: String, amountTsp: Int = 1, temperatureF: Int = 212, steepTimeMin: Int = 4, restTimeMin: Int = 4) {
        self.id = UUID().uuidString
        self.name = name
        self.amountTsp = amountTsp
        self.temperatureF = temperatureF
        self.steepTimeMin = steepTimeMin
        self.restTimeMin = restTimeMin
    }
}
