import Foundation

enum ApiType {

    case getTotal
    case getCounries
    
    var baseUrl: String {
        return "https://api.covid19api.com/"
    }

    var headers: [String: String] {
        switch self {
        default:
            return [:]
        }
    }

    var path: String {
        switch self {
        case .getTotal:
            return "summary"
        case .getCounries:
            return "countries"
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
}