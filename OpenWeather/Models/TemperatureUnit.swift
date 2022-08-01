import Foundation

enum TemperatureUnit: String, CaseIterable {
    case fahrenheit = "F"
    case celsius = "C"

    var label: String {
        switch self {
        case .fahrenheit:
            return "° F"
        case .celsius:
            return "° C"
        }
    }

    var apiString: String {
        switch self {
        case .fahrenheit:
            return "imperial"
        case .celsius:
            return "metric"
        }
    }
}
