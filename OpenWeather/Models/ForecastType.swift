import Foundation

enum ForecastType: String {
    case current
    case minutely
    case hourly
    case daily
    case alerts

    static var unsupported: [ForecastType] {
        [.minutely, .daily, .alerts]
    }
}
