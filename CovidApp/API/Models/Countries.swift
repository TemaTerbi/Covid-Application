//
//  Countries.swift
//  CovidApp
//
//  Created by TeRb1 on 11.06.2022.
//

import Foundation

// MARK: - Counry
struct Countries: Codable {
    let country, slug, iso2: String?

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
        case iso2 = "ISO2"
    }
}


