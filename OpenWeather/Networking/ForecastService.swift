import Foundation

// can use to return specialized errors
// ex) You're using a REST API and it returns specific status code which can map to one of these
enum ForecastServiceError: Error {
    case couldNotConstructRequest
    case networkingError
    case dataError
    case unexpected
}

protocol ForecastServiceProtocol {
    func getCurrentForecast(lat: Double, lon: Double, temperatureUnit: TemperatureUnit) async throws -> CurrentForecast
    func getHourlyForecast(lat: Double, lon: Double, temperatureUnit: TemperatureUnit) async throws -> HourlyForecast
}

class ForecastService: ForecastServiceProtocol {

    private let networkManager: NetworkManagerProtocol
    private let requestBuilder: ForecastRequestBuilderProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         requestBuilder: ForecastRequestBuilderProtocol = ForecastRequestBuilder()) {
        self.networkManager = networkManager
        self.requestBuilder = requestBuilder
    }

    func getCurrentForecast(lat: Double, lon: Double, temperatureUnit: TemperatureUnit) async throws -> CurrentForecast {
        guard let request = requestBuilder.buildForecastRequest(lat: lat, lon: lon, units: temperatureUnit, isHourly: false) else {
            throw ForecastServiceError.couldNotConstructRequest
        }

        do {
            let data = try await networkManager.performGetRequest(using: request)
            let decoder = JSONDecoder()
            return try decoder.decode(CurrentForecast.self, from: data)
        } catch {
            // specific error handling; using generic errors for example purposes
            // also log analytics if supported

            if let networkError = error as? NetworkError {
                // handle supported network error
                switch networkError {
                default:
                    throw ForecastServiceError.networkingError
                }
            } else if let dataError = error as? DecodingError {

                // handle these cases to whatever level needed, keeping it simple for example purposes
                switch dataError {
                case .typeMismatch,
                        .valueNotFound,
                        .keyNotFound,
                        .dataCorrupted:
                    throw ForecastServiceError.dataError
                @unknown default:
                    throw ForecastServiceError.unexpected
                }
            }

            throw ForecastServiceError.unexpected
        }
    }

    func getHourlyForecast(lat: Double, lon: Double, temperatureUnit: TemperatureUnit) async throws -> HourlyForecast {
        guard let request = requestBuilder.buildForecastRequest(lat: lat, lon: lon, units: temperatureUnit, isHourly: true) else {
            throw ForecastServiceError.couldNotConstructRequest
        }

        do {
            let data = try await networkManager.performGetRequest(using: request)
            let decoder = JSONDecoder()
            return try decoder.decode(HourlyForecast.self, from: data)
        } catch {
            if let networkError = error as? NetworkError {
                // handle supported network error
                switch networkError {
                default:
                    throw ForecastServiceError.networkingError
                }
            } else if let dataError = error as? DecodingError {
                switch dataError {
                case .typeMismatch,
                        .valueNotFound,
                        .keyNotFound,
                        .dataCorrupted:
                    throw ForecastServiceError.dataError
                @unknown default:
                    throw ForecastServiceError.unexpected
                }
            }

            throw ForecastServiceError.unexpected
        }
    }
}
