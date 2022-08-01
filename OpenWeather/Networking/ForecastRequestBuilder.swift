import Foundation

protocol ForecastRequestBuilderProtocol {
    func buildForecastRequest(lat: Double, lon: Double, units: TemperatureUnit, isHourly: Bool) -> URLRequest?
}

class ForecastRequestBuilder: ForecastRequestBuilderProtocol {
    enum Endpoint: String {
        case forecastCity = "/data/2.5/forecast?q=@"
        case forecastCoordinates = "/data/2.5/onecall"

        func getHTTPMethod() -> HTTPMethod {
            switch self {
            case .forecastCity:
                return .get
            case .forecastCoordinates:
                return .get
            }
        }
    }

    // can also throw errors if data validation is needed before making request
    func buildForecastRequest(lat: Double, lon: Double, units: TemperatureUnit, isHourly: Bool) -> URLRequest? {
        let urlString = Constants.baseURL + Endpoint.forecastCoordinates.rawValue

        let excludedForecast: ForecastType = isHourly ? .current : .hourly
        let exclusions = ForecastType.unsupported + [excludedForecast]

        var components = URLComponents(string: urlString)
        components?.queryItems = [URLQueryItem(name: "appid", value: Constants.apiKey),
                                  URLQueryItem(name: "lat", value: String(lat)),
                                  URLQueryItem(name: "lon", value: String(lon)),
                                  URLQueryItem(name: "units", value: units.apiString),
                                  URLQueryItem(name: "exclude", value: exclusions.map { $0.rawValue }.joined(separator: ","))]
        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }

}

