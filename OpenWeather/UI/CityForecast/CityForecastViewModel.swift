import Foundation

@MainActor
class CityForecastViewModel: ObservableObject {
    @Published var forecast: WeatherForecast?
    @Published var isLoading: Bool = false

    let place: Place
    private let forecastService: ForecastServiceProtocol

    init(place: Place,
         forecastService: ForecastServiceProtocol = ForecastService()) {
        self.place = place
        self.forecastService = forecastService
    }

    func fetchWeatherForecast(units: TemperatureUnit) async {
        isLoading = true
        do {
            let currentForecast = try await forecastService.getCurrentForecast(lat: place.latitude,
                                                                       lon: place.longitude,
                                                                       temperatureUnit: units)
            self.forecast = currentForecast.current
            self.isLoading = false
        } catch {
            // handle error with published var and alert in ui
            isLoading = false
        }
    }
}
