import Foundation

// Using default coding keys and computed vars to preserve default init which is helpful for previews and mock data for tests (for preference)
// could also use custom coding keys and/or drill down multiple levels in init with decoder
struct WeatherForecast: Codable, Hashable {
    let dt: Int
    let temp: Double
    let weather: [DailyForecastWeather]

    var forecast: Weather {
        switch weather.first?.id ?? 0 {
        case 200...299:
            return .thunderstorm
        case 300...399:
            return .drizzle
        case 500...599:
            return .rain
        case 600...699:
            return .snow
        case 700...799:
            return .fog
        case 800:
            return .clear
        case 802:
            return .clouds
        default:
            return .generic
        }
    }
}

extension WeatherForecast {
    var date: Date {
        Date(timeIntervalSince1970: Double(dt))
    }

    var sunriseTime: String {
        Date(timeIntervalSince1970: Double(dt)).ampmTimeString
    }

    var sunsetTime: String {
        Date(timeIntervalSince1970: Double(dt)).ampmTimeString
    }

    var displayTemperature: Int {
        return Int(round(temp))
    }

    var title: String? {
        return weather.first?.main
    }

    var description: String? {
        return weather.first?.description.capitalized
    }
}

struct DailyForecastTemperature: Codable, Hashable {
    let day: Double
    let night: Double
}

struct DailyForecastWeather: Codable, Hashable {
    let id: Int
    let main: String
    let description: String
}
