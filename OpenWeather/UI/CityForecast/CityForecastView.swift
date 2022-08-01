import SwiftUI

struct CityForecastView: View {
    @EnvironmentObject var viewModel: CityForecastViewModel
    // could also use

    @Binding var units: TemperatureUnit

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(viewModel.place.city)
                .font(.system(size: 20, weight: .semibold))

            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(3)
                }

                if let weatherForecast = viewModel.forecast {
                    HStack {
                        VStack {
                            Text("\(weatherForecast.displayTemperature)\(units.label)")
                                .font(.system(size: 48, weight: .bold))

                            Text(weatherForecast.title ?? "")
                                .font(.subheadline)
                        }

                        Spacer()

                        Image(systemName: weatherForecast.forecast.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchWeatherForecast(units: units)
            }
        }
    }
}

struct CityForecastView_Previews: PreviewProvider {
    static var previews: some View {
        CityForecastView(units: .constant(.fahrenheit))
    }
}
