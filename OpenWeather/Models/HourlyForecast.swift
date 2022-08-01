import Foundation

struct HourlyForecast: Codable {
    let lat: Double
    let lon: Double
    let hourly: [WeatherForecast]
}
