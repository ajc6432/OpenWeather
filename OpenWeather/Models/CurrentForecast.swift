import Foundation

struct CurrentForecast: Codable {
    let lat: Double
    let lon: Double
    let current: WeatherForecast
}
