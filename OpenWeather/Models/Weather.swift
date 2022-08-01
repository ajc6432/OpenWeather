import SwiftUI

enum Weather {
    case thunderstorm
    case rain
    case drizzle
    case fog
    case clear
    case clouds
    case snow
    case generic

    var imageName: String {
        switch self {
        case .thunderstorm:
            return Asset.thunderstorm.rawValue
        case .rain:
            return Asset.rain.rawValue
        case .drizzle:
            return Asset.drizzle.rawValue
        case .fog:
            return Asset.fog.rawValue
        case .clear:
            return Asset.clear.rawValue
        case .clouds:
            return Asset.clouds.rawValue
        case .snow:
            return Asset.snow.rawValue
        case .generic:
            return Asset.genericWeather.rawValue
        }
    }
}
