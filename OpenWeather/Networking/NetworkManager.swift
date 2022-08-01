import Foundation

enum NetworkError: Error {
    case systemLevel(String)
    case invalidStatusCode(Int)
    case unexpected
}

protocol NetworkManagerProtocol {
    func performGetRequest(using request: URLRequest) async throws -> Data
}

class NetworkManager: NetworkManagerProtocol {
    func performGetRequest(using request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpUrlResponse = response as? HTTPURLResponse else { throw NetworkError.unexpected } // expect a status code back
            guard Array(200...299).contains(httpUrlResponse.statusCode) else { throw NetworkError.invalidStatusCode(httpUrlResponse.statusCode) } // check status
            return data
        } catch {
            throw NetworkError.systemLevel(error.localizedDescription)
        }
    }
}
