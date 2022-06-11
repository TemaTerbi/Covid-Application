//
//  Country.swift
//  CovidApp
//
//  Created by TeRb1 on 11.06.2022.
//

import Foundation

// MARK: - CountryElement
struct CountryElement: Codable {
    let cases: Int?

    enum CodingKeys: String, CodingKey {
        case cases = "Cases"
    }
}


typealias byCountry = [CountryElement]
