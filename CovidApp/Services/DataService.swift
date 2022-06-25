//
//  DataService.swift
//  CovidApp
//
//  Created by TeRb1 on 11.06.2022.
//

import Foundation

final class DataService {
    static let shared = DataService()
    
    var arrayCountries = [Countries]()
    var monthCases: Int = 0
    var arrayCases = [Int?]()
    var sortedCases: Array<Int?>.SubSequence = []
    var boolLoop = true
    var items: [Item] = []
    
    func updateData() {
        sortedCases = arrayCases.prefix(12)
    }
    
    func getValue() {
        var dayCounter = 0
        if boolLoop {
            for el in sortedCases {
                items.append(Item(type: String(dayCounter), values: Double(el ?? 0)))
                dayCounter += 1
            }
        }
        boolLoop = false
    }
}
