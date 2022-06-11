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
}
