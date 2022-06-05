import Foundation

struct Global: Codable {
    let id, message: String?
    let global: GlobalClass?
    let countries: [Country]?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case message = "Message"
        case global = "Global"
        case countries = "Countries"
    }
}

// MARK: - Country
struct Country: Codable {
    let id, country, countryCode, slug: String?
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int?
    let newRecovered, totalRecovered: Int?
    let premium: Premium?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case country = "Country"
        case countryCode = "CountryCode"
        case slug = "Slug"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
        case premium = "Premium"
    }
}

// MARK: - Premium
struct Premium: Codable {
    let countryStats: CountryStats?

    enum CodingKeys: String, CodingKey {
        case countryStats = "CountryStats"
    }
}

// MARK: - CountryStats
struct CountryStats: Codable {
    let id, countryISO, country: String?
    let continent: Continent?
    let population: Int?
    let populationDensity, medianAge, aged65Older, aged70Older: Double?
    let extremePoverty: Int?
    let gdpPerCapita: Double?
    let cvdDeathRate: Int?
    let diabetesPrevalence, handwashingFacilities, hospitalBedsPerThousand, lifeExpectancy: Double?
    let femaleSmokers, maleSmokers: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case countryISO = "CountryISO"
        case country = "Country"
        case continent = "Continent"
        case population = "Population"
        case populationDensity = "PopulationDensity"
        case medianAge = "MedianAge"
        case aged65Older = "Aged65Older"
        case aged70Older = "Aged70Older"
        case extremePoverty = "ExtremePoverty"
        case gdpPerCapita = "GdpPerCapita"
        case cvdDeathRate = "CvdDeathRate"
        case diabetesPrevalence = "DiabetesPrevalence"
        case handwashingFacilities = "HandwashingFacilities"
        case hospitalBedsPerThousand = "HospitalBedsPerThousand"
        case lifeExpectancy = "LifeExpectancy"
        case femaleSmokers = "FemaleSmokers"
        case maleSmokers = "MaleSmokers"
    }
}

enum Continent: String, Codable {
    case africa = "Africa"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - GlobalClass
struct GlobalClass: Codable {
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int?
    let newRecovered, totalRecovered: Int?

    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}


