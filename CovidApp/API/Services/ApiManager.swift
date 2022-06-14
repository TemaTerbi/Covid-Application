import Foundation

private let storage = UserDefaults.standard


enum ApiType {
    var getIso: String {
        return UserDefaults.standard.string(forKey: "selectIso") ?? ""
    }

    case getTotal
    case getCounries
    case getByCountry
    
    var baseUrl: String {
        return "https://api.covid19api.com/"
    }

    var headers: [String: String] {
        switch self {
        default:
            return [:]
        }
    }
    
    var iso: String {
        return getIso
    }

    var path: String {
        switch self {
        case .getTotal:
            return "summary"
        case .getCounries:
            return "countries"
        case .getByCountry:
            return "country/\(iso)/status/confirmed?from=2022-03-01T00:00:00Z&to=2022-04-01T00:00:00Z"
        }
    }

    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseUrl)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        switch self {
        default:
            request.httpMethod = "GET"
            return request
        }
    }
}

final class ApiManager {

    static let shared = ApiManager()

    func getTotal(completion: @escaping (Global) -> Void) {
        let request = ApiType.getTotal.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let global = try? JSONDecoder().decode(Global.self, from: data) {
                completion(global)
            } else {
                print("Network Error: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
    }
    
    func getCounries(completion: @escaping ([Countries]) -> Void) {
        let request = ApiType.getCounries.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let countries = try? JSONDecoder().decode([Countries].self, from: data) {
                completion(countries)
            } else {
                print("Network Error: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
    }
    
    func getByCountry(completion: @escaping (ByCountry) -> Void) {
        let request = ApiType.getByCountry.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let country = try? JSONDecoder().decode(ByCountry.self, from: data) {
                completion(country)
            } else {
                print("Network Error: \(String(describing: error))")
            }
        }
        task.resume()
    }
}
