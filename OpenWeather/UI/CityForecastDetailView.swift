import SwiftUI

struct CityForecastDetailView: View {
    @EnvironmentObject var viewModel: CityForecastDetailViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(3)
            }
            
            VStack {
                Text(viewModel.place.city)
                    .font(.title)
                
                Text("Hourly Forecast:")
                    .font(.subheadline)
                
                List(viewModel.hourlyforecasts, id: \.self) { forecast in
                    HourlyForecastView(forecast: forecast, units: viewModel.units)
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchWeatherForecast()
            }
        }
    }
}

struct HourlyForecastView: View {
    let forecast: WeatherForecast
    let units: TemperatureUnit
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(forecast.date.ampmTimeString)
            
            HStack {
                Image(systemName: forecast.forecast.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .padding(.horizontal)
                
                Spacer()
                
                VStack {
                    Text("\(forecast.displayTemperature)\(units.label)")
                        .font(.system(size: 48, weight: .bold))
                    
                    Text(forecast.title ?? "")
                        .font(.subheadline)
                }
            }
        }
    }
}

@MainActor
class CityForecastDetailViewModel: ObservableObject {
    @Published var hourlyforecasts: [WeatherForecast] = []
    @Published var isLoading: Bool = false
    
    let place: Place
    let units: TemperatureUnit
    private let forecastService: ForecastServiceProtocol
    
    init(place: Place,
         units: TemperatureUnit,
         forecastService: ForecastServiceProtocol = ForecastService()) {
        self.place = place
        self.units = units
        self.forecastService = forecastService
    }
    
    func fetchWeatherForecast() async {
        isLoading = true
        do {
            let current = try await forecastService.getHourlyForecast(lat: place.latitude,
                                                                      lon: place.longitude,
                                                                      temperatureUnit: units)
            self.hourlyforecasts = current.hourly
            self.isLoading = false
        } catch {
            // handle error with published var and alert in ui
            isLoading = false
        }
    }
}
